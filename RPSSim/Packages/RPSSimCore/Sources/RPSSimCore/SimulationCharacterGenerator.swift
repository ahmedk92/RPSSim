//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation

private let DENSITY_FACTOR: CGFloat = 0.05

public final class SimulationCharacterGenerator {
    public init() {}
    
    func generateCharacters(
        viewFrameSize: CGSize,
        characterFrameSize: CGSize
    ) -> [SimulationCharacterViewModel] {
        let characterCount = self.characterCount(
            viewFrameSize: viewFrameSize,
            characterFrameSize: characterFrameSize
        )
        
        return (0..<characterCount).map { _ in
            let characterViewModel = SimulationCharacterViewModel()
            characterViewModel.type.send(SimulationCharacterType.allCases.randomElement()!)
            characterViewModel.frame.send(randomCharacterRect(
                viewFrameSize: viewFrameSize,
                characterFrameSize: characterFrameSize
            ))
            return characterViewModel
        }
    }
    
    private func characterCount(
        viewFrameSize: CGSize,
        characterFrameSize: CGSize
    ) -> Int {
        Int((viewFrameSize.area() * DENSITY_FACTOR) / characterFrameSize.area())
    }
    
    private func randomCharacterRect(
        viewFrameSize: CGSize,
        characterFrameSize: CGSize
    ) -> CGRect {
        .init(
            origin: .init(
                x: (0...Int(viewFrameSize.width - characterFrameSize.width)).randomElement() ?? 0,
                y: (0...Int(viewFrameSize.height - characterFrameSize.height)).randomElement() ?? 0
            ),
            size: characterFrameSize
        )
    }
}

private extension CGSize {
    func area() -> CGFloat {
        width * height
    }
}
