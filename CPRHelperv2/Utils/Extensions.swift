//
//  Extensions.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import SwiftUI
import AVKit
import MediaPlayer

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

///To increase wolume when opening the pusling view
func increaseVolume() {
    do {
        try AVAudioSession.sharedInstance().setActive(true)
        let currentVolume = AVAudioSession.sharedInstance().outputVolume
        
        // This will show the system volume HUD
        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                slider.value = 0.5
            }
        }
    } catch {
        print("Error setting audio session: \(error)")
    }
}

