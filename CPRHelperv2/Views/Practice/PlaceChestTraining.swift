//
//  PlaceChestTraining.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 02.02.2025.
//

import SwiftUI

///View to train the placement of the hands for performing CPR
struct PlaceChestTraining: View {
    
    @Binding var isActive:PracticePage?
    
    var body: some View {
        VStack{
            Text("Train where to do CPR")
                .font(.title)
            Text("Try to tap to a place where you think you should perform CPR")
            PlaceChestView(activeView: $isActive)
            Text("Placement is key to correct CPR, try to remember form the chapter about How to do CPR the right placement.")
                .font(.caption)
                .padding(.vertical)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    PlaceChestTraining(isActive:  .constant(PracticePage(type: .history)))
}
