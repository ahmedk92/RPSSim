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
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
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
        
        operationQueue.isSuspended = true
        operationQueue.addOperation { [weak self] in
            guard let self = self else { return }
            Task { @MainActor in
                self.simulationViewFrameSizeProvider.simulationView = self.simulationView
                await self.simulationController.startSimulation()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        operationQueue.isSuspended = false
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
