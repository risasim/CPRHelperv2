//
//  CPRAudio.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.

import AVFoundation
import MediaPlayer
import UIKit
import SwiftUI

///Class that handles the beeps during the resuscitaion
@Observable
class CPRAudioModel {
    private var audioPlayer: AVAudioPlayer?
    private var countingTimer: Timer?
    //Numbers of beep that sounded from the start of the sessoin.
    private var beepCount: Int = 0
    //If there is currently break in the compressions for the breaths
    private var isBreathing: Bool = false
    ///Image in the ``PulsingView```
    var image = "uncompressed"
    ///Whether sound should be played
    var soundOn: Bool = true {
        didSet {
            updateAudioState()
        }
    }
    ///Whether the CPR is performed with breaths
    var withBreaths: Bool = false {
        didSet {
            restartCounting()
        }
    }
    ///Status of the currenct situation
    var status: String = "Resuscitate"
    ///If the model is active
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
    
    init(startSound: Bool = true) {
        setupAudioSession()
        setupAudioPlayer()
        updateStatus()
        self.soundOn = startSound
#if DEBUG
        self.soundOn = false
#endif
        #if os(iOS)
        let volume = MPVolumeView().subviews.first(where: { $0 is UISlider }) as? UISlider
        volume?.value = 1
        #endif
    }
    
    //Prepares before playng the sounds
    private func setupAudioSession() {
        do {
#if os(watchOS)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            #else
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
#endif
            try AVAudioSession.sharedInstance().setActive(true)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(handleInterruption),
                                                   name: AVAudioSession.interruptionNotification,
                                                   object: nil)
        } catch {
            print("Failed to set audio session category. Error: \(error)")
        }
    }
    
    //Prepares the players for playing the beeps
    private func setupAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: "wav") else {
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
    
    //Handles interruptions of the audio playing
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
    
    ///Toggles if the audio should be played.
    func toggleActive() {
        isActive.toggle()
    }
    
    //Starts the counter and ideally the audio session
    private func startCounting() {
        stopCounting()
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session. Error: \(error)")
        }
        restartCounting()
    }
    
    //Restarts the whole thing
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
    
    //When you play without breaths
    private func countContinuous() {
        if soundOn {
            playBeep()
        }else{
            fakePlayBeep()
        }
        beepCount += 1
        updateStatus()
    }
    
    //When with breaths, having pauses
    private func countWithBreaths() {
        if self.isBreathing {
            self.image = "breathe"
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
                }else{
                    fakePlayBeep()
                }
                self.beepCount += 1
            }
        }
        updateStatus()
    }
    
    //Upadtes the status on the View showing what to do
    private func updateStatus() {
        if withBreaths {
            self.status = isBreathing ? "Do two breaths" : "Resuscitate \(30-beepCount)"
        } else {
            self.status = "Resuscitate \(beepCount)"
        }
    }
    
    //Plays the on beep
    private func playBeep() {
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
        self.image = "compressed"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + beepDuration) {
            self.audioPlayer?.stop()
            self.image = "uncompressed"
        }
    }
    
    //When no beep should be played but we need the same logic
    private func fakePlayBeep() {
        self.image = "compressed"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + beepDuration) {
            self.image = "uncompressed"
        }
    }
    
    //Stops the counter
    private func stopCounting() {
        audioPlayer?.stop()
        countingTimer?.invalidate()
        countingTimer = nil
        beepCount = 0
        isBreathing = false
        updateStatus()
    }
    
    //Updates the audio state, can start or end the audio
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
