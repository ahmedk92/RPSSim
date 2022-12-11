//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import Combine
import RPSSimCore

public final class SimulationCharacterView: UIView {
    private let simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver
    var viewModel: SimulationCharacterViewModel? {
        didSet {
            updateView()
        }
    }
    private var label: UILabel!
    private var cancellables: Set<AnyCancellable> = []
    
    public init(simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver) {
        self.simulationCharacterEmojiResolver = simulationCharacterEmojiResolver
        super.init(frame: .zero)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        setUpLabel()
    }
    
    private func setUpLabel() {
        label = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateView() {
        cancellables = []
        
        guard let viewModel = viewModel else { return }
        
        viewModel.type
            .compactMap({ $0 })
            .sink { [weak self] type in
                guard let self = self else { return }
                self.label.text = self.simulationCharacterEmojiResolver.emoji(characterType: type)
            }.store(in: &cancellables)
        
        viewModel.frame
            .compactMap({ $0 })
            .sink { [weak self] frame in
                guard let self = self else { return }
                self.frame = frame
            }.store(in: &cancellables)
    }
}
