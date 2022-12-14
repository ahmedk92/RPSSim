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
    private let simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator
    var viewModel: SimulationCharacterViewModel? {
        didSet {
            updateView()
        }
    }
    private var label: UILabel!
    private var cancellables: Set<AnyCancellable> = []
    
    public init(simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator) {
        self.simulationCharacterLabelConfigurator = simulationCharacterLabelConfigurator
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
        
        let throttleTime: CGFloat = 0.5
        
        viewModel.type
            .compactMap({ $0 })
            .combineLatest(viewModel.frame.compactMap({ $0 }))
            .sink { [weak self] type, frame in
                guard let self = self else { return }
                UIView.animate(
                    withDuration: throttleTime,
                    animations: {
                        self.frame = frame
                    },
                    completion: { _ in
                        self.simulationCharacterLabelConfigurator.configure(
                            label: self.label,
                            forType: type
                        )
                    }
                )
            }.store(in: &cancellables)
    }
}
