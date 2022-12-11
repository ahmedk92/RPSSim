//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationController {
    private let simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider
    public var viewModel: SimulationViewModel = .init()
    
    public init(simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider) {
        self.simulationCharacterFrameSizeProvider = simulationCharacterFrameSizeProvider
    }
    
    public func startSimulation() {
        let dummyCharacter1 = SimulationCharacterViewModel(type: .rock)
        dummyCharacter1.frame.send(
            .init(
                origin: .init(
                    x: 100,
                    y: 100
                ),
                size: simulationCharacterFrameSizeProvider.size()
            )
        )
        viewModel.characters.send([
            dummyCharacter1
        ])
    }
}
