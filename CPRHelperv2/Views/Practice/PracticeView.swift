//
//  PracticeView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct PracticeView: View {
    var body: some View {
        VStack{
            NavigationLink {
                HeartView()
            } label: {
                PracticeListItem(text: "About humans heart",image: "heart")
            }
            NavigationLink {
                Text("What")
            } label: {
                PracticeListItem(text: "What is CPR?",systemImage: "questionmark.circle")
            }
            NavigationLink {
                Text("Bla Bla")
            } label: {
                PracticeListItem(text: "When to do CPR?", systemImage: "clock")
            }
            NavigationLink {
                PlaceChestTraining(isActive: .constant(PracticePage(type: .history)))
            } label: {
                PracticeListItem(text: "Where to do CPR?",systemImage: "location")
            }
            NavigationLink {
                Text("Bla Bla")
            } label: {
                PracticeListItem(text: "How to do CPR?",systemImage: "figure.mind.and.body")
            }
        }
    }
}

#Preview {
    PracticeView()
}
