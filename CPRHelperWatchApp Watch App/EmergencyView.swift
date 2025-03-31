//
//  EmergencyView.swift
//  CPRHelperWatchApp Watch App
//
//  Created by Richard Šimoník on 31.03.2025.
//

import SwiftUI

struct EmergencyView: View {
    @Binding var model:EmergencyModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EmergencyView(model: .constant(EmergencyModel()))
}
