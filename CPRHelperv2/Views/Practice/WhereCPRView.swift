//
//  WhereCPRView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct WhereCPRView: View {
    var body: some View {
        VStack{
            Text("Try to tap in a place where you think CPR should be performed:")
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
            PlaceChestView()
        }
    }
}

#Preview {
    WhereCPRView()
}
