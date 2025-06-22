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
            Text("Onboarding.legalTitle")
                .padding()
                .font(.title2)
                .bold()
            Text("""
    Onboarding.legal
    """)
            .font(.caption2)
            .multilineTextAlignment(.leading)
            Spacer()
            Button {
                opened = true
            } label: {
                Label("Onboarding.close", systemImage: "xmark")
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
