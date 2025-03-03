//
//  PuslingView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI
import MediaPlayer

///View showing the animation and setup for the sound aid of the CPR
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
            VStack{
                Spacer()
                Text("\(audio.status)")
                Image(audio.image)
                    .resizable()
                    .scaledToFit()
                    .offset(y:8)
            }
            HStack{
                Toggle("Sound on", isOn: $audio.soundOn)
                    .font(.headline)
                    .padding(5)
                    .toggleStyle(PulsingToggleStyle(systemImageActive: "speaker.wave.2", systemImageNonActive: "speaker.slash"))
                    .minimumScaleFactor(0.001)
                Spacer(minLength: 40)
                Toggle("With breaths", isOn: $audio.withBreaths)
                    .font(.headline)
                    .padding(5)
                    .toggleStyle(PulsingToggleStyle(systemImageActive: "lungs", systemImageNonActive: "lungs.slash",nonCustom: false))
                    .minimumScaleFactor(0.001)
            }
            .background(content: {
                ZStack{
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
    EmergencyView(model: .constant(EmergencyModel()))
}

