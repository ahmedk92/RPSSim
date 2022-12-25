//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore

public final class SimulationCharacterFrameSizeProvider: RPSSimCore.SimulationCharacterFrameSizeProvider {
    private let simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator
    private let simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver
    
    public init(
        simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator,
        simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver
    ) {
        self.simulationCharacterLabelConfigurator = simulationCharacterLabelConfigurator
        self.simulationCharacterEmojiResolver = simulationCharacterEmojiResolver
    }
    
    func emoji(characterType: SimulationCharacterType) -> String {
        simulationCharacterEmojiResolver.emoji(characterType: characterType)
    }
    
    @MainActor
    public func size() async -> CGSize {
        var maxWidth: CGFloat = 0
        var maxHeight: CGFloat = 0
        
        for characterType in SimulationCharacterType.allCases {
            let label = UILabel()
            simulationCharacterLabelConfigurator.configure(
                label: label,
                forType: characterType
            )
            label.sizeToFit()
            
            maxWidth = max(maxWidth, label.bounds.width)
            maxHeight = max(maxHeight, label.bounds.height)
        }
        
        return .init(
            width: maxWidth,
            height: maxHeight
        )
    }
}
