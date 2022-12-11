//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationCharacterPositionAdvancer {
    public init() {}
    
    func advance(
        characterViewModels: [SimulationCharacterViewModel],
        viewFrame: CGRect
    ) {
        for characterViewModel in characterViewModels {
            advance(
                characterViewModel: characterViewModel,
                viewFrame: viewFrame
            )
        }
    }
    
    private func advance(
        characterViewModel: SimulationCharacterViewModel,
        viewFrame: CGRect
    ) {
        let nextPosition = possibleMoves(
            characterViewModel: characterViewModel,
            viewFrame: viewFrame
        ).randomElement()!
        characterViewModel.frame.send(nextPosition)
    }
    
    private func possibleMoves(
        characterViewModel: SimulationCharacterViewModel,
        viewFrame: CGRect
    ) -> [CGRect] {
        guard let currentCharacterFrame = characterViewModel.frame.value else { return [] }
        
        var moves: [CGRect] = []
        let xDeltas: [CGFloat] = [-1, 0, 1]
        let yDeltas: [CGFloat] = [-1, 0, 1]
        for xDelta in xDeltas {
            for yDelta in yDeltas {
                var candidateCharacterFrame = currentCharacterFrame
                candidateCharacterFrame.origin.x += xDelta
                candidateCharacterFrame.origin.y += yDelta
                
                if viewFrame.contains(candidateCharacterFrame) {
                    moves.append(candidateCharacterFrame)
                }
            }
        }
        return moves
    }
}
