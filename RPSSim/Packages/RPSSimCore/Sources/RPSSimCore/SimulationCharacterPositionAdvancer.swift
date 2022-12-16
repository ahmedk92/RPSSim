//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

public final class SimulationCharacterPositionAdvancer {
    
    public init() {
    }
    
    @MainActor
    func advance(
        characterViewModels: [SimulationCharacterViewModel],
        viewFrame: CGRect
    ) async {
        await withTaskGroup(of: Void.self) { group in
            for (characterViewModel, index) in zip(characterViewModels, characterViewModels.indices) {
                group.addTask { [weak self] in
                    guard let self = self else { return }
                    await self.advance(
                        characterViewModel: characterViewModel,
                        viewFrame: viewFrame,
                        index: index
                    )
                }
            }
            
            await group.waitForAll()
        }
    }
    
    @MainActor
    private func advance(
        characterViewModel: SimulationCharacterViewModel,
        viewFrame: CGRect,
        index: Int
    ) async {
        let nextPosition = possibleMoves(
            characterViewModel: characterViewModel,
            viewFrame: viewFrame
        ).randomElement()!
        characterViewModel.frame.send(nextPosition)
        
        try? await Task.sleep(nanoseconds: UInt64(index) * 1000)
    }
    
    private func possibleMoves(
        characterViewModel: SimulationCharacterViewModel,
        viewFrame: CGRect
    ) -> [CGRect] {
        guard let currentCharacterFrame = characterViewModel.frame.value else { return [] }
        
        var moves: [CGRect] = []
        let deltas: [CGFloat] = [-1, -2, -3, 0, 1, 2, 3]
        for xDelta in deltas {
            for yDelta in deltas {
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
