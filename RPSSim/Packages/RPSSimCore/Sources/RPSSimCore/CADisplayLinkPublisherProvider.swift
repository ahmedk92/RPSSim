//
//  File.swift
//  
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import Combine

public final class CADisplayLinkPublisherProvider {
    private let subject: PassthroughSubject<Void, Never> = .init()
    public private(set) lazy var publisher: some Publisher<Void, Never> = subject
    
    public init() {
        CADisplayLink(target: self, selector: #selector(caDisplayLinkCallback)).add(to: .main, forMode: .common)
    }
    
    @objc private func caDisplayLinkCallback() {
        subject.send(())
    }
}
