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
    
    public var viewModel: SimulationViewModel = .init()
    
    public init(
        simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider,
        simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider,
        simulationCharacterGenerator: SimulationCharacterGenerator
    ) {
        self.simulationCharacterFrameSizeProvider = simulationCharacterFrameSizeProvider
        self.simulationViewFrameSizeProvider = simulationViewFrameSizeProvider
        self.simulationCharacterGenerator = simulationCharacterGenerator
    }
    
    public func startSimulation() {
        viewModel.characters.send(simulationCharacterGenerator.generateCharacters(
            viewFrameSize: simulationViewFrameSizeProvider.size(),
            characterFrameSize: simulationCharacterFrameSizeProvider.size()
        ))
    }
}
