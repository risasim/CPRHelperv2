//
//  MainView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

struct MainView: View {
    
    @State var isInfoActive: Bool = false
    @State var practiceActive:Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(){
                AnimatedAppLabel(appName: "CPR Helper")
                    .padding(.bottom)
                NavigationLink {
                    EmergencyView()
                } label: {
                    Label("Emergency", systemImage: "waveform.path.ecg")
                        .font(.largeTitle)
                        .labelStyle(MainLabelStyle(isEmergency: true))
                }
                Button {
                    practiceActive.toggle()
                } label: {
                    Label("Practice", systemImage: "heart.text.square.fill")
                        .font(.title)
                        .labelStyle(MainLabelStyle(isDotted: true))
                        .padding(.vertical)
                }

                Spacer()
                Button(action: {isInfoActive.toggle()}, label: {
                    Label("Info", systemImage: "info.circle")
                })
                .buttonStyle(MainButtonStyle())
                .padding(.top)
            }
            .padding()
            .sheet(isPresented: $practiceActive, content: {
                NavigationStack{
                    PracticeTimelineView(active: $practiceActive)
                }
                    .presentationDetents([.medium])
            })
            .sheet(isPresented: $isInfoActive, content: {
                InfoView(active: $isInfoActive)
            })
        }
        .fontDesign(.monospaced)
        .accentColor(.primary)
    }
}


#Preview {
    MainView()
}
