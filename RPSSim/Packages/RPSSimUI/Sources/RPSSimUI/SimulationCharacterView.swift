//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import Combine
import RPSSimCore

public final class SimulationCharacterView: UIView {
    var viewModel: SimulationCharacterViewModel? {
        didSet {
            updateView()
        }
    }
    
    private var label: UILabel!
    private var frameCancellable: AnyCancellable?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        setUpLabel()
    }
    
    private func setUpLabel() {
        label = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateView() {
        label.text = viewModel?.type.emoji
        frameCancellable = viewModel?.frame
            .compactMap({ $0 })
            .sink { [weak self] frame in
            guard let self = self else { return }
                self.frame = frame
        }
    }
}

private extension SimulationCharacterType {
    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📜"
        case .scissors:
            return "✂️"
        }
    }
}
