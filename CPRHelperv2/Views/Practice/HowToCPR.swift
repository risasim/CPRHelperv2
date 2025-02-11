//
//  HowToCPR.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

struct HowToCPR: View {
    
    @State private var audio = CPRAudioModel(startSound: false)
    @State private var showPractice = false
    @Binding var activeView:PracticePage?
    
    var body: some View {
        VStack{
            Text("How to Perform CPR")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom,5)
            ScrollView{
                //TODO add picture of clearing airways
                Text(cprGuidePart1)
                HStack{
                    EmergencyChecklistView()
                    Text(checklistExplain)
                        .fontWeight(.medium)
                }
                .padding()
                .borderedBackground()
                .multilineTextAlignment(.leading)
                Text(cprGuidePart3)
                VStack{
                    Text("With the right rhytm and the timing of breaths (if you decide to do them) there is the audio aid, if you are going to do a compression on the beep, you will have cadence of 100 compressions/minute.")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .padding()
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
                }
                .borderedBackground()
                Text(cprGuidePart2)
            }
            Button {
                showPractice.toggle()
            } label: {
                Text("Practice")
                    .padding()
                    .borderedBackground()
            }
        }
        .navigationDestination(isPresented: $showPractice, destination: {
            CPRTimelineView(activeView: $activeView)
        })
        .padding(.horizontal)
        .onAppear{
            audio.isActive = true
        }
    }
}



#Preview {
    NavigationStack{
        HowToCPR(activeView: .constant(PracticePage.init(type: PracticeOptions.history)))
            .fontDesign(.monospaced)
    }
}
