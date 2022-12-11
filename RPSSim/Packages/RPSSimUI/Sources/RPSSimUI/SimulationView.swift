//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore
import Combine

public final class SimulationView: UIView {
    private let simulationCharacterViewAttributesProvider: SimulationCharacterViewAttributesProvider
    
    public var viewModel: SimulationViewModel? {
        didSet {
            observeViewModel()
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    private var characterViews: [SimulationCharacterView] = []
    
    public init(simulationCharacterViewAttributesProvider: SimulationCharacterViewAttributesProvider) {
        self.simulationCharacterViewAttributesProvider = simulationCharacterViewAttributesProvider
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observeViewModel() {
        viewModel?.characters.sink { [weak self] characters in
            guard let self = self else { return }
            self.reloadView(forCharacters: characters)
        }.store(in: &cancellables)
    }
    
    private func reloadView(forCharacters characterViewModels: [SimulationCharacterViewModel]) {
        characterViews.forEach({ $0.removeFromSuperview() })
        
        for characterViewModel in characterViewModels {
            addCharacterView(characterViewModel: characterViewModel)
        }
    }
    
    private func addCharacterView(characterViewModel: SimulationCharacterViewModel) {
        let characterView = SimulationCharacterView(
            simulationCharacterViewAttributesProvider: simulationCharacterViewAttributesProvider
        )
        characterView.viewModel = characterViewModel
        addSubview(characterView)
        characterViews.append(characterView)
    }
}
