//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation
import CoreGraphics
import Combine

public final class SimulationController {
    private let simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider
    private let simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider
    private let simulationCharacterGenerator: SimulationCharacterGenerator
    private let simulationCharacterPositionAdvancer: SimulationCharacterPositionAdvancer
    private let caDisplayLinkPublisherProvider: CADisplayLinkPublisherProvider
    private let simulationCharacterCollisionResolver: SimulationCharacterCollisionResolver
    
    public var viewModel: SimulationViewModel = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    public init(
        simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider,
        simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider,
        simulationCharacterGenerator: SimulationCharacterGenerator,
        simulationCharacterPositionAdvancer: SimulationCharacterPositionAdvancer,
        caDisplayLinkPublisherProvider: CADisplayLinkPublisherProvider,
        simulationCharacterCollisionResolver: SimulationCharacterCollisionResolver
    ) {
        self.simulationCharacterFrameSizeProvider = simulationCharacterFrameSizeProvider
        self.simulationViewFrameSizeProvider = simulationViewFrameSizeProvider
        self.simulationCharacterGenerator = simulationCharacterGenerator
        self.simulationCharacterPositionAdvancer = simulationCharacterPositionAdvancer
        self.caDisplayLinkPublisherProvider = caDisplayLinkPublisherProvider
        self.simulationCharacterCollisionResolver = simulationCharacterCollisionResolver
    }
    
    public func startSimulation() {
        viewModel.characters.send(simulationCharacterGenerator.generateCharacters(
            viewFrameSize: simulationViewFrameSizeProvider.size(),
            characterFrameSize: simulationCharacterFrameSizeProvider.size()
        ))
        
        Timer.publish(every: 0.05, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            
            Task { @MainActor in
                await self.simulationCharacterPositionAdvancer.advance(
                    characterViewModels: self.viewModel.characters.value,
                    viewFrame: .init(
                        origin: .zero,
                        size: self.simulationViewFrameSizeProvider.size()
                    )
                )
                
                self.simulationCharacterCollisionResolver.resolve(characterViewModels: self.viewModel.characters.value)
            }
        }.store(in: &cancellables)
    }
}
