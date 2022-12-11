//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationController {
    public var viewModel: SimulationViewModel = .init()
    
    public init() {
        let dummyCharacter1 = SimulationCharacterViewModel(type: .rock)
        dummyCharacter1.frame.send(
            .init(
                origin: .init(
                    x: 100,
                    y: 100
                ),
                size: .init(
                    width: 10,
                    height: 10
                )
            )
        )
        viewModel.characters.send([
            dummyCharacter1
        ])
    }
}
