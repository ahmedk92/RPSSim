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
        let simulationCharacterViewAttributesProvider = SimulationCharacterViewAttributesProvider(
            simulationCharacterLabelConfigurator: .init(
                simulationCharacterEmojiResolver: simulationCharacterEmojiResolver
            ),
            simulationCharacterEmojiResolver: simulationCharacterEmojiResolver
        )
        return SimulationViewController(
            simulationController: .init(
                simulationCharacterFrameSizeProvider: simulationCharacterViewAttributesProvider
            ),
            simulationCharacterViewAttributesProvider: simulationCharacterViewAttributesProvider
        )
    }
}
