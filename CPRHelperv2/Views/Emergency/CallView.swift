//
//  CallView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

struct CallView: View {
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "phone")
            Text("Call ambulance")
                .padding(.horizontal,5)
                .multilineTextAlignment(.center)
        }
        .bold()
        .font(.largeTitle)
        .lineLimit(2)
        .minimumScaleFactor(0.1)
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background {
            Color.red.clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1))
        )
        .padding(.trailing,5)
    }
}

#Preview {
    MainView()
}
