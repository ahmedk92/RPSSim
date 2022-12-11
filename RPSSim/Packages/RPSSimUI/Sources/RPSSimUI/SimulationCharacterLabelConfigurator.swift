//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore

public final class SimulationCharacterLabelConfigurator {
    private let simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver
    
    public init(simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver) {
        self.simulationCharacterEmojiResolver = simulationCharacterEmojiResolver
    }
    
    func configure(
        label: UILabel,
        forType characterType: SimulationCharacterType
    ) {
        label.text = simulationCharacterEmojiResolver.emoji(characterType: characterType)
    }
}
