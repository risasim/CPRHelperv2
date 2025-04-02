//
//  EmergencyView.swift
//  CPRHelperWatchApp Watch App
//
//  Created by Richard Šimoník on 31.03.2025.
//

import SwiftUI

struct EmergencyView: View {
    @Binding var model:EmergencyModel
    var body: some View {
        VStack{
            Text("Time: \(model.timeLabel)")
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
                Text("\(model.audioModel.status)")
                Image(model.audioModel.image)
                    .resizable()
                    .scaledToFit()
                    .offset(y:8)
            }
            HStack{
                Toggle("Sound on", isOn: $model.audioModel.soundOn)
                    .toggleStyle(PulsingToggleStyle(systemImageActive: "speaker.wave.2", systemImageNonActive: "speaker.slash"))
                    .minimumScaleFactor(0.001)
                Spacer(minLength: 40)
                Toggle("With breaths", isOn: $model.audioModel.withBreaths)
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
      //  .ignoresSafeArea()
       
    }
}

#Preview {
    EmergencyView(model: .constant(EmergencyModel()))
}
