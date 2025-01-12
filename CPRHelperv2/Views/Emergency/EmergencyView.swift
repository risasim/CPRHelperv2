//
//  EmergencyView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI
import AVKit
import MediaPlayer

///Main view for emergency, showing all of the stuff 
struct EmergencyView: View {
    
    @Bindable var model:EmergencyModel = EmergencyModel()
    
    var body: some View {
        VStack{
            PulsingView(time: $model.timeLabel,audio: $model.audioModel)
                .padding(.horizontal,5)
                .onAppear(perform: {
                    model.startTimer()
                })
                .onDisappear(perform: {
                    model.startTimer()
                })
            HStack{
                EmergencyChecklistView()
                CallView()
                    .onTapGesture {
                        model.callNumber()
                    }
            }
            .frame(maxHeight: 250)
            Text("Resuscitate until the ambulance arrive")
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding(.horizontal,20)
        }
        .onAppear(perform: {
            model.audioModel.toggleActive()
            increaseVolume()
        })
        .onDisappear(perform: {
            model.audioModel.toggleActive()
        })
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Keep yourself safe")
                    .bold()
            }
        })
    }
}

#Preview {
    EmergencyView()
}


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

