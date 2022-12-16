//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 16/12/2022.
//

import Foundation
import CoreGraphics

public class SimulationCharacterFramePathResolver {
    public init() {}
    
    public func resolve(characterFrame: CGRect) -> SimulationCharacterFramePath? {
        let row = Int(characterFrame.minX / characterFrame.width)
        let column = Int(characterFrame.minY / characterFrame.height)
        
        return .init(
            row: row,
            column: column
        )
    }
}
