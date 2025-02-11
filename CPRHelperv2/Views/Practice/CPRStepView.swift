//
//  CPRStepView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import SwiftUI

struct CPRStepView: View {
    @State var index: Int
    @Binding var item: CPRStep
    
    var body: some View {
        HStack {
            Text("\(index + 1))")
            TextField("", text: $item.name)
            Spacer()
        }
        .foregroundStyle(Color.white)
        .font(Font.title)
        .minimumScaleFactor(0.001)
        .padding()
        .background(
            ZStack{
                Color.red
                WornOutTextureView()
            }
        )
        .cornerRadius(8)
        .borderedBackground()
    }
}

#Preview {
    CPRStepView(index: 6, item: .constant(CPRStep(name: "Hello", correctOrder: 3)))
}
