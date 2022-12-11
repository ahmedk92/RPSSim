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
    private let simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver
    private let simulationViewFrameSizeProvider: RPSSimUI.SimulationViewFrameSizeProvider
    private let simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator
    
    private var simulationView: SimulationView!
    
    init(
        simulationController: SimulationController,
        simulationCharacterEmojiResolver: SimulationCharacterEmojiResolver,
        simulationViewFrameSizeProvider: RPSSimUI.SimulationViewFrameSizeProvider,
        simulationCharacterLabelConfigurator: SimulationCharacterLabelConfigurator
    ) {
        self.simulationController = simulationController
        self.simulationCharacterEmojiResolver = simulationCharacterEmojiResolver
        self.simulationViewFrameSizeProvider = simulationViewFrameSizeProvider
        self.simulationCharacterLabelConfigurator = simulationCharacterLabelConfigurator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        simulationView.viewModel = simulationController.viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        simulationViewFrameSizeProvider.simulationView = simulationView
        simulationController.startSimulation()
    }
    
    private func setUpView() {
        simulationView = .init(
            simulationCharacterEmojiResolver: simulationCharacterEmojiResolver,
            simulationCharacterLabelConfigurator: simulationCharacterLabelConfigurator
        )
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
