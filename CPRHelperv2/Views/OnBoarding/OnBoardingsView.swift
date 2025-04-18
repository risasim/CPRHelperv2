//
//  OnBoardingsView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 05.02.2025.
//

import SwiftUI

struct OnBoardingsView: View {
    var body: some View {
        ZStack{
            Color.clear
                .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .ignoresSafeArea()
            TabView {
                OnBoarding1View()
                OnBoarding2View()
                OnBoarding3View()
                OnBoardingView4()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    OnBoardingsView()
        .fontDesign(.monospaced)
}
