//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 16/12/2022.
//

import Foundation

public struct SimulationCharacterFramePath: Hashable {
    public var row: Int
    public var column: Int
    
    public init(
        row: Int,
        column: Int
    ) {
        self.row = row
        self.column = column
    }
}
