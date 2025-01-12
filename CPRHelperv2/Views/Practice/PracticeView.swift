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
                PlaceChestView()
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
    LearnView()
}

import SwiftUI

struct LearnView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Branching Story Path Menu
                    Text("Learn CPR")
                        .font(.largeTitle)
                        .bold()

                    VStack(spacing: 15) {
                        NavigationLink(destination: CPRDetailView(title: "What is CPR?")) {
                            MenuNode(title: "What is CPR?", icon: "questionmark.circle")
                        }

                        NavigationLink(destination: CPRDetailView(title: "When to Use CPR")) {
                            MenuNode(title: "When to Use CPR", icon: "calendar.badge.exclamationmark")
                        }

                        NavigationLink(destination: CPRDetailView(title: "How to Perform CPR")) {
                            MenuNode(title: "How to Perform CPR", icon: "hands.sparkles")
                        }
                    }
                }
                .padding()

                // Carousel Menu
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        CarouselCard(title: "CPR Basics", description: "Learn the essentials.", icon: "book.fill")
                        CarouselCard(title: "Emergency Response", description: "React quickly.", icon: "bolt.fill")
                        CarouselCard(title: "Advanced Techniques", description: "For experienced responders.", icon: "star.fill")
                    }
                    .padding()
                }
            }
        }
    }
}

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

struct CarouselCard: View {
    let title: String
    let description: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)

                Text(title)
                    .font(.headline)
            }

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 200, height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct CPRDetailView: View {
    let title: String

    var body: some View {
        Text("Details for \(title)")
            .font(.largeTitle)
            .padding()
    }
}

