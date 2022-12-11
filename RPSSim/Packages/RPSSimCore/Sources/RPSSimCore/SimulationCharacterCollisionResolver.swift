//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationCharacterCollisionResolver {
    public init() {}
    
    func resolve(
        characterViewModels: [SimulationCharacterViewModel]
    ) {
        var aCollisionWasResolved = false
        repeat {
            aCollisionWasResolved = false
            doResolve(
                characterViewModels: characterViewModels,
                didResolve: &aCollisionWasResolved
            )
        } while aCollisionWasResolved
    }
    
    private func doResolve(
        characterViewModels: [SimulationCharacterViewModel],
        didResolve: inout Bool
    ) {
        for characterViewModel1 in characterViewModels {
            for characterViewModel2 in characterViewModels where characterViewModel1 !== characterViewModel2 {
                guard
                    let frame1 = characterViewModel1.frame.value,
                    let frame2 = characterViewModel2.frame.value,
                    frame1.intersects(frame2),
                    let type1 = characterViewModel1.type.value,
                    let type2 = characterViewModel2.type.value
                else { continue }
                
                switch (type1, type2) {
                case (.rock, .scissors):
                    characterViewModel2.type.send(.rock)
                    didResolve = true
                case (.paper, .rock):
                    characterViewModel2.type.send(.paper)
                    didResolve = true
                case (.scissors, .paper):
                    characterViewModel2.type.send(.scissors)
                    didResolve = true
                default:
                    break
                }
            }
        }
    }
}
