//
//  CPRStepView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import SwiftUI

///View for one step of the CPR for ``CPRTimelineView``
struct CPRStepView: View {
    @State var index: Int
    @Binding var item: CPRStep
    
    var body: some View {
        HStack {
            Text(item.name)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.title3)
            Spacer()
        }
        .fontDesign(.monospaced)
        .foregroundStyle(Color.white)
        .padding()
        .background(
            ZStack{
                Color.red
                WornOutTextureView()
                if(item.correctOrder == 6 || item.correctOrder == 7){
                    Color.white.opacity(0.2)
                }
            }
        )
        .cornerRadius(8)
        .borderedBackground()
    }
}

#Preview {
    CPRTimelineView(activeView: .constant(PracticePage.init(type: PracticeOptions.history)))
        .fontDesign(.monospaced)
}
