//
//  EmergencyModel.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import UIKit
import AVKit

protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}

@Observable
final class EmergencyModel {
    var timeLabel: String = "00:00:00"
    private var stopwatchTimer: Timer?
    private var elapsedTime: TimeInterval = 0
    
    let openURL: OpenURLProtocol
    var audioModel: CPRAudioModel = CPRAudioModel()
    
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    
    func startTimer() {
        if let timer = stopwatchTimer {
            timer.invalidate()
            stopwatchTimer = nil
            elapsedTime = 0
            timeLabel = "00:00"
        } else {
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
                self?.elapsedTime += timer.timeInterval
                let minutes = Int(self?.elapsedTime ?? 0) / 60 % 60
                let seconds = Int(self?.elapsedTime ?? 0) % 60
                self?.timeLabel = String(format: "%02d:%02d", minutes, seconds)
            }
        }
    }
    
    func callNumber() {
        DispatchQueue.main.async {
            guard let url = URL(string: "tel://08000480408") else { return }
            self.openURL.open(url)
        }
    }
}

