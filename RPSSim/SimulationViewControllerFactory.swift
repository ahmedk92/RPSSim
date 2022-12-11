//
//  SimulationViewControllerFactory.swift
//  RPSSim
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore
import RPSSimUI

final class SimulationViewControllerFactory {
    func makeSimulationViewController() -> SimulationViewController {
        let simulationCharacterEmojiResolver = SimulationCharacterEmojiResolver()
        let simulationCharacterFrameSizeProvider = SimulationCharacterFrameSizeProvider(
            simulationCharacterLabelConfigurator: .init(
                simulationCharacterEmojiResolver: simulationCharacterEmojiResolver
            ),
            simulationCharacterEmojiResolver: simulationCharacterEmojiResolver
        )
        
        let simulationViewFrameSizeProvider = RPSSimUI.SimulationViewFrameSizeProvider()
        
        return SimulationViewController(
            simulationController: .init(
                simulationCharacterFrameSizeProvider: simulationCharacterFrameSizeProvider,
                simulationViewFrameSizeProvider: simulationViewFrameSizeProvider,
                simulationCharacterGenerator: .init(),
                simulationCharacterPositionAdvancer: .init(),
                caDisplayLinkPublisherProvider: .init(),
                simulationCharacterCollisionResolver: .init()
            ),
            simulationCharacterEmojiResolver: simulationCharacterEmojiResolver,
            simulationViewFrameSizeProvider: simulationViewFrameSizeProvider
        )
    }
}
