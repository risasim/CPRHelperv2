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

///Class that is handlind the timing and the calling in ``EmergencyView``
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
    
    ///Starts the timer to show how long is the cpr performed for.
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
    
    ///Tries to call emergency number
    func callNumber() {
        let emergencyNumber = UserDefaults.standard.string(forKey: "emergencyNumber") ?? "911"
        DispatchQueue.main.async {
            guard let url = URL(string: "tel://\(emergencyNumber)") else { return }
            self.openURL.open(url)
        }
    }
}

