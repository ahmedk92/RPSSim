//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation
import CoreGraphics

public final class SimulationController {
    private let simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider
    private let simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider
    private let simulationCharacterGenerator: SimulationCharacterGenerator
    private let simulationCharacterPositionAdvancer: SimulationCharacterPositionAdvancer
    
    public var viewModel: SimulationViewModel = .init()
    
    public init(
        simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider,
        simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider,
        simulationCharacterGenerator: SimulationCharacterGenerator,
        simulationCharacterPositionAdvancer: SimulationCharacterPositionAdvancer
    ) {
        self.simulationCharacterFrameSizeProvider = simulationCharacterFrameSizeProvider
        self.simulationViewFrameSizeProvider = simulationViewFrameSizeProvider
        self.simulationCharacterGenerator = simulationCharacterGenerator
        self.simulationCharacterPositionAdvancer = simulationCharacterPositionAdvancer
    }
    
    public func startSimulation() {
        viewModel.characters.send(simulationCharacterGenerator.generateCharacters(
            viewFrameSize: simulationViewFrameSizeProvider.size(),
            characterFrameSize: simulationCharacterFrameSizeProvider.size()
        ))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.simulationCharacterPositionAdvancer.advance(
                characterViewModels: self.viewModel.characters.value,
                viewFrame: .init(
                    origin: .zero,
                    size: self.simulationViewFrameSizeProvider.size()
                )
            )
        }
    }
}
