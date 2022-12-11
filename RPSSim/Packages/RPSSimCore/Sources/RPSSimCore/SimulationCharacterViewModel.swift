//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation
import Combine

public final class SimulationCharacterViewModel {
    public let type: SimulationCharacterType
    public let frame: CurrentValueSubject<CGRect?, Never> = .init(nil)
    
    public init(type: SimulationCharacterType) {
        self.type = type
    }
}
