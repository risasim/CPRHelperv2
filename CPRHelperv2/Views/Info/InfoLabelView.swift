//
//  InfoLabelView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

struct InfoLabelView: View {
    
    var label: String
    var image: String
    
    var body: some View {
        HStack{
            Text(LocalizedStringKey(label))
                .textCase(.uppercase)
            Spacer()
            Image(systemName: image)
        }
        .fontWeight(.bold)
    }
}

#Preview {
    InfoLabelView(label: "Application", image: "iphone")
}
