//
//  PuslingView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI
import MediaPlayer

struct PulsingView: View {
    @Binding var time:String
    @Binding var audio:CPRAudioModel
    
    var body: some View {
        VStack{
            Text("Time: \(time)")
                .font(.title3)
                .padding(.vertical,5)
                .frame(maxWidth: .infinity)
                .background(content: {
                    Color.gray.opacity(0.3)
                })
                .clipShape(
                    .rect(
                        topLeadingRadius: 10,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 10
                    )
                )
            Spacer()
            Text("\(audio.status)")
            Text("Animation")
            Spacer()
            HStack{
                Toggle("Sound on", isOn: $audio.soundOn)
                    .font(.headline)
                    .padding(5)
                    .toggleStyle(PulsingToggleStyle(systemImageActive: "speaker.wave.2", systemImageNonActive: "speaker.slash"))
                Spacer(minLength: 40)
                Toggle("With breaths", isOn: $audio.withBreaths)
                    .font(.headline)
                    .padding(5)
                    .toggleStyle(PulsingToggleStyle(systemImageActive: "lungs", systemImageNonActive: "lungs.slash",nonCustom: false))
            }
            .background(content: {
                ZStack{
                    Color.white
                    Color.gray.opacity(0.3)
                }
            })
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 0
                )
            )
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 3))
        )
    }
}

#Preview {
    EmergencyView()
}

