//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation
import RPSSimCore

public final class SimulationCharacterEmojiResolver {
    public init() {}
    
    public func emoji(characterType: SimulationCharacterType) -> String {
        switch characterType {
        case .rock:
            return "🪨"
        case .paper:
            return "📜"
        case .scissors:
            return "✂️"
        }
    }
}
