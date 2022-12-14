//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore

public final class SimulationViewFrameSizeProvider: RPSSimCore.SimulationViewFrameSizeProvider {
    public weak var simulationView: UIView!
    
    public init() {}
    
    @MainActor
    public func size() async -> CGSize {
        simulationView.frame.size
    }
}
