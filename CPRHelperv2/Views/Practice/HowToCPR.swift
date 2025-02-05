//
//  HowToCPR.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

struct HowToCPR: View {
    
    @State private var audio = CPRAudioModel(startSound: false)
    
    var body: some View {
        VStack{
            Text("How to Perform CPR")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            ScrollView{
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
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .onAppear{
            audio.isActive = true
        }
    }
    
    let cprGuidePart1:LocalizedStringResource = """
    **1. Check the Scene** – Ensure the area is safe before approaching the person.  
    
    **2. Check Responsiveness** – Tap the person and shout, *"Are you okay?"* If there is no response, proceed. 
    
    **3. Call for Help** – Dial emergency services (e.g., **112** in Europe, **911** in the U.S., you can set the default emergency number in the settings). If others are around, ask someone to get an **AED** (Automated External Defibrillator).  
    
    **4. Check for Breathing** – Look, listen, and feel for normal breathing for no more than **10 seconds**. If the person is not breathing or only gasping, start CPR.  
    
    **5. Open the Airway** – Tilt the head back and lift the chin to prevent the tongue from blocking the airway.
    """
    let checklistExplain = "Until now you can find the steps in Checklist that is found in the Emergency part of this app. Check indicates if that thing should be found or not. The Checklist is interactive."
    let cprGuidePart3:LocalizedStringResource = """
    **6. Give Chest Compressions** –
        - Place both hands in the center of the chest.
        - Push hard and fast (*5-6 cm deep*, at a rate of *100-120 compressions per minute*).
        - Allow the chest to fully recoil between compressions.
    
    **7. Rescue Breaths (if trained)** 
        - Pinch the nose, give **two breaths**, ensuring the chest rises.
        - Continue with **30 compressions**, then **2 breaths**.
        - If unsure, stick to **hands-only CPR** (continuous compressions).
    """
    let cprGuidePart2:LocalizedStringResource = """
    **8. Use an AED (if available)** – Follow its voice instructions.  
    
    **9. Continue CPR** – Do not stop until medical help arrives or the person starts breathing.  
    """
}



#Preview {
    HowToCPR()
        .fontDesign(.monospaced)
}
