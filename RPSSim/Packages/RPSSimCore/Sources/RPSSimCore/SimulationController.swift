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
    public var viewModel: SimulationViewModel = .init()
    
    public init(
        simulationCharacterFrameSizeProvider: SimulationCharacterFrameSizeProvider,
        simulationViewFrameSizeProvider: SimulationViewFrameSizeProvider
    ) {
        self.simulationCharacterFrameSizeProvider = simulationCharacterFrameSizeProvider
        self.simulationViewFrameSizeProvider = simulationViewFrameSizeProvider
    }
    
    public func startSimulation() {
        let dummyCharacter1 = SimulationCharacterViewModel()
        dummyCharacter1.type.send(.paper)
        dummyCharacter1.frame.send(
            randomCharacterRect(
                containerRect: .init(
                    origin: .zero,
                    size: simulationViewFrameSizeProvider.size()
                ),
                size: simulationCharacterFrameSizeProvider.size()
            )
        )
        viewModel.characters.send([
            dummyCharacter1
        ])
    }
    
    private func randomCharacterRect(
        containerRect: CGRect,
        size: CGSize
    ) -> CGRect {
        .init(
            origin: .init(
                x: (Int(containerRect.minX)...Int(containerRect.maxX - size.width)).randomElement() ?? 0,
                y: (Int(containerRect.minY)...Int(containerRect.maxY - size.height)).randomElement() ?? 0
            ),
            size: size
        )
    }
}
