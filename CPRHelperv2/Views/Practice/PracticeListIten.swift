//
//  PracticeListIten.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct PracticeListItem: View {
    
    var text:String
    var image:String?=nil
    var systemImage:String?=nil
    
    var body: some View {
        HStack{
            if let img = image{
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
            }else if let sImg = systemImage{
                Image(systemName: sImg)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
            }
            Text(text)
                .font(.title2)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 3))
        )
        .padding(.horizontal)
    }
}

#Preview {
    PracticeListItem(text: "How to do CPR?")
}
