//
//  CPRAudio.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.

import AVFoundation
import MediaPlayer
import UIKit
import SwiftUI

class CPRAudioModel {
    private var audioPlayer: AVAudioPlayer?
    private var countingTimer: Timer?
    private var beepCount: Int = 0
    private var isBreathing: Bool = false
    var soundOn: Bool = true {
        didSet {
            updateAudioState()
        }
    }
    var withBreaths: Bool = false {
        didSet {
            restartCounting()
        }
    }
    var status: String = "Resuscitate"
    var isActive: Bool = false {
        didSet {
            if isActive {
                startCounting()
            } else {
                stopCounting()
            }
        }
    }
    
    // CPR timing constants
    private let beepDuration: TimeInterval = 0.153  // 150 milliseconds
    private let beepInterval: TimeInterval = 0.6   // 100 BPM
    
    init() {
        setupAudioSession()
        setupAudioPlayer()
        updateStatus()
#if DEBUG
        self.soundOn = false
#endif
        let volume = MPVolumeView().subviews.first(where: { $0 is UISlider }) as? UISlider
        volume?.value = 1
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(handleInterruption),
                                                   name: AVAudioSession.interruptionNotification,
                                                   object: nil)
        } catch {
            print("Failed to set audio session category. Error: \(error)")
        }
    }
    
    private func setupAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "beeeep", withExtension: "wav") else {
            print("Beep sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error setting up audio player: \(error.localizedDescription)")
        }
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        switch type {
        case .began:
            stopCounting()
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                if isActive {
                    startCounting()
                }
            }
        @unknown default:
            break
        }
    }
    
    func toggleActive() {
        isActive.toggle()
    }
    
    private func startCounting() {
        stopCounting()
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session. Error: \(error)")
        }
        restartCounting()
    }
    
    private func restartCounting() {
        stopCounting()
        beepCount = 0
        isBreathing = false
        
        countingTimer = Timer.scheduledTimer(withTimeInterval: beepInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.withBreaths {
                self.countWithBreaths()
            } else {
                self.countContinuous()
            }
        }
    }
    
    private func countContinuous() {
        if soundOn {
            playBeep()
        }
        beepCount += 1
        updateStatus()
    }
    
    private func countWithBreaths() {
        if self.isBreathing {
            if self.beepCount >= 6 {
                self.isBreathing = false
                self.beepCount = 0
            } else {
                self.beepCount += 1
            }
        } else {
            if self.beepCount >= 30 {
                self.isBreathing = true
                self.beepCount = 0
            } else {
                if soundOn {
                    playBeep()
                }
                self.beepCount += 1
            }
        }
        updateStatus()
    }
    
    private func updateStatus() {
        if withBreaths {
            status = isBreathing ? "Do two breaths" : "Resuscitate \(30-beepCount)"
        } else {
            status = "Resuscitate (\(beepCount))"
        }
    }
    
    private func playBeep() {
        debugPrint("wtf")
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + beepDuration) {
            self.audioPlayer?.stop()
        }
    }
    
    private func stopCounting() {
        audioPlayer?.stop()
        countingTimer?.invalidate()
        countingTimer = nil
        beepCount = 0
        isBreathing = false
        updateStatus()
    }
    
    private func updateAudioState() {
        if isActive {
            if soundOn {
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch {
                    print("Failed to activate audio session. Error: \(error)")
                }
            } else {
                do {
                    try AVAudioSession.sharedInstance().setActive(false)
                } catch {
                    print("Failed to deactivate audio session. Error: \(error)")
                }
            }
        }
    }
}
