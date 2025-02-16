//
//  OnBoardingView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 04.02.2025.
//

import SwiftUI

///View that will welocme the user and introduce him to the app and the concept.
struct OnBoarding2View: View {
    @State private var model = EmergencyModel()
    var body: some View {
        VStack{
            Text(onboarding2)
                .font(.title2)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            EmergencyView(model: $model,isOnBoarding: true)
                .minimumScaleFactor(0.001)
                .frame(maxWidth: 360)
                .padding()
                .borderedBackground()
                .padding([.bottom,.leading,.trailing])
                .disabled(true)
            Spacer()
        }
        
    }
}

#Preview {
    OnBoarding2View()
        .fontDesign(.monospaced)
}
