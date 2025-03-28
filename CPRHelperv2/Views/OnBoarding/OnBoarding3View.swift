//
//  OnBoarding3View.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 05.02.2025.
//

import SwiftUI

///Onbarding view for the practice.
struct OnBoarding3View: View {
    var body: some View {
        VStack{
            Spacer()
            Text(onboarding3)
                .font(.title2)
                .padding()
                .multilineTextAlignment(.leading)
            PracticeTimelineView(active: .constant(false), practiceDetailActive: .constant(false), practiceDetailType: .constant(nil),onboarding: true)
                .disabled(true)
                .padding()
                .borderedBackground()
                .padding()
            Spacer()
        }
    }
}

#Preview {
    OnBoarding3View()
        .fontDesign(.monospaced)
}
