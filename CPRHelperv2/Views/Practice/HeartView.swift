//
//  HeartView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct HeartView: View {
    @State private var scale: CGFloat = 1.0
    @State private var selectedTab = 0
    @State private var selectedFact = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GIFView()
                #if DEBUG
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 4))
                    )
                #endif
                VStack{
                    HStack{
                       Label("Did you know?", systemImage: "info.circle")
                        Spacer()
                    }
                    .font(.footnote)
                    .fontWeight(.light)
                    .padding(.top,5)
                    .padding(.leading,5)
                    heartFacts[selectedFact]
                        .padding(.bottom,5)
                    
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background {
                    Color.black.clipShape(RoundedRectangle(cornerRadius: 10)).opacity(0.1)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                )
                .padding(.trailing,5)
                
                Picker("Information", selection: $selectedTab) {
                    Text("Facts").tag(0)
                    Text("How it Works").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                switch selectedTab {
                case 0:
                    importanceText
                case 1:
                    howItWorksList
                default:
                    EmptyView()
                }
            }
            .padding()
        }
        .onAppear(perform: {
            selectedFact = Int.random(in: 0..<4)
        })
    }
    
    var howItWorksList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("How the Heart Works:")
                .font(.title2)
                .fontWeight(.bold)
            Text("1. Blood enters the right atrium")
            Text("2. Contracts, pushing blood to right ventricle")
            Text("3. Right ventricle pumps blood to lungs")
            Text("4. Oxygenated blood returns to left atrium")
            Text("5. Left ventricle pumps blood to body")
            Text("6. Process repeats continuously")
        }
    }
    
    var importanceText: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("The Importance of the Heart")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("The heart is an extraordinary organ that plays a central role in our survival and well-being. As the core of the circulatory system, it acts as a powerful pump that keeps our body functioning optimally.")
            
            Text("One of the heart's primary functions is to supply oxygen and essential nutrients to every cell in our body. With each beat, it pushes oxygen-rich blood through a vast network of blood vessels, ensuring that even the most distant cells receive the fuel they need to function.")
            
            Text("Beyond its role in nutrient delivery, the heart is crucial for removing waste products from our body. As blood circulates, it collects carbon dioxide and other metabolic waste, which are then filtered out by the kidneys and lungs.")
            
            Text("The heart also plays a vital role in regulating body temperature and supporting our immune system. By efficiently circulating blood, it helps distribute heat throughout the body and enables white blood cells to travel where they're needed to fight off infections.")
            
            Text("In essence, the heart's tireless work allows us to perform all our daily activities, from basic bodily functions to complex physical and mental tasks. Its health is intimately tied to our overall well-being, making it one of the most important organs in the human body.")
        }
    }
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY ))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.height/4),
                      control1: CGPoint(x: rect.midX, y: rect.height*3/4),
                      control2: CGPoint(x: rect.minX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.width/4, y: rect.height/4),
                    radius: rect.width/4,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addArc(center: CGPoint(x: rect.width*3/4, y: rect.height/4),
                    radius: rect.width/4,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.height),
                      control1: CGPoint(x: rect.width, y: rect.midY),
                      control2: CGPoint(x: rect.midX, y: rect.height*3/4))
        
        return path
    }
}

#Preview {
    HeartView()
}
