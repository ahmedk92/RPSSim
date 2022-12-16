//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationCharacterCollisionResolver {
    private let simulationCharacterFramePathResolver: SimulationCharacterFramePathResolver
    private var occupations: [SimulationCharacterFramePath : [SimulationCharacterViewModel]] = [:]
    
    public init(simulationCharacterFramePathResolver: SimulationCharacterFramePathResolver) {
        self.simulationCharacterFramePathResolver = simulationCharacterFramePathResolver
    }
    
    public func resolve(character: SimulationCharacterViewModel) {
        removeOccupation(character: character)
        
        guard
            let characterFrame = character.frame.value,
            let path = simulationCharacterFramePathResolver.resolve(characterFrame: characterFrame)
        else { return }
        
        occupations[path, default: []].append(character)
        
        convertOccupants(occupants: occupations[path] ?? [])
    }
    
    private func removeOccupation(character: SimulationCharacterViewModel) {
        for entry in occupations {
            if let characterIndex = entry.value.firstIndex(where: { $0 === character }) {
                occupations[entry.key]?.remove(at: characterIndex)
            }
        }
    }
    
    private func convertOccupants(occupants: [SimulationCharacterViewModel]) {
        for occupant1 in occupants {
            for occupant2 in occupants where occupant1 !== occupant2 {
                guard
                    let type1 = occupant1.type.value,
                    let type2 = occupant2.type.value
                else { continue }
                
                switch (type1, type2) {
                case (.rock, .scissors):
                    occupant2.type.send(.rock)
                case (.paper, .rock):
                    occupant2.type.send(.paper)
                case (.scissors, .paper):
                    occupant2.type.send(.scissors)
                default:
                    continue
                }
            }
        }
    }
}
