//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import Foundation
import Combine

public final class SimulationViewModel {
    public let characters: CurrentValueSubject<[SimulationCharacterViewModel], Never> = .init([])
}
