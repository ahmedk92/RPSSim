//
//  SimulationViewController.swift
//  RPSSim
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore
import RPSSimUI

class SimulationViewController: UIViewController {
    private let simulationController: SimulationController
    private let simulationCharacterViewAttributesProvider: SimulationCharacterViewAttributesProvider
    
    private var simulationView: SimulationView!
    
    init(
        simulationController: SimulationController,
        simulationCharacterViewAttributesProvider: SimulationCharacterViewAttributesProvider
    ) {
        self.simulationController = simulationController
        self.simulationCharacterViewAttributesProvider = simulationCharacterViewAttributesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        simulationView.viewModel = simulationController.viewModel
        simulationController.startSimulation()
    }
    
    private func setUpView() {
        simulationView = .init(simulationCharacterViewAttributesProvider: simulationCharacterViewAttributesProvider)
        simulationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(simulationView)
        NSLayoutConstraint.activate([
            simulationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            simulationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            simulationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            simulationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
