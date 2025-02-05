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
                .padding()
                .multilineTextAlignment(.leading)
            EmergencyView(model: $model)
                .padding()
                .minimumScaleFactor(0.001)
                .frame(maxWidth: 380)
                .disabled(true)
                .borderedBackground()
        }
        
    }
}

#Preview {
    OnBoarding2View()
        .fontDesign(.monospaced)
}
