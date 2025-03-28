//
//  OnBoardingView4.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 28.03.2025.
//

import SwiftUI

struct OnBoardingView4: View {
    @AppStorage("opened") var opened: Bool = false
    var body: some View {
        VStack{
            Spacer()
            Text("Before you dive in to app, some legal stuff:")
                .padding()
                .font(.title2)
                .bold()
            Text("""
    The CPR Helper app is designed for informational and educational purposes only. It does not replace professional medical training, certification, or emergency services. The app provides guidance based on established CPR principles; however, it does not guarantee accuracy, effectiveness, or appropriateness in any specific situation.

    By using this app, you acknowledge and agree that:

    You are solely responsible for your actions and decisions when performing CPR.
    The developers, distributors, and affiliates of this app are not liable for any injuries, damages, or outcomes resulting from the use or inability to use this app.
    This app is not a substitute for professional medical advice, emergency medical services, or hands-on CPR training.
    If you encounter a medical emergency, you should call emergency services immediately.
    Limitation of Liability
    To the fullest extent permitted by law, the CPR Helper app and its creators disclaim all liability for any direct, indirect, incidental, consequential, or special damages arising from or related to the use of this app, including but not limited to injury, death, or legal claims.

    By continuing to use this app, you confirm that you understand and accept these terms.
    """)
            .font(.caption2)
            Spacer()
            Button {
                opened = true
            } label: {
                Label("Exit onboarding", systemImage: "xmark")
                    .padding()
                    .borderedBackground()
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    OnBoardingView4()
        .fontDesign(.monospaced)
}
