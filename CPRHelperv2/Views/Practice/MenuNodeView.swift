//
//  MenuNodeView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 06.02.2025.
//

import SwiftUI


struct MenuNode: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.primary)
                .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
