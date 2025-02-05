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
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding().frame(maxWidth: 200)
                HStack{
                    Text("Hello!")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                Text(onboarding1)
                    .padding()
                Spacer()
            }
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    OnBoarding1View()
}
