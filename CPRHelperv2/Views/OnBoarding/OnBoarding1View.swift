//
//  OnBoarding1View.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 05.02.2025.
//

import SwiftUI

struct OnBoarding1View: View {
    var body: some View {
        ZStack{
           
            VStack{
                Spacer()
                HStack{
                    Text("Hello!")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
                Text(onboarding1)
                    .font(.title2)
                    .padding()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding().frame(maxWidth: 200)
                Spacer()
            }
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    OnBoarding1View()
}
