//
//  ContentView.swift
//  CPRHelperWatchApp Watch App
//
//  Created by Richard Šimoník on 31.03.2025.
//

import SwiftUI

struct MainView: View {
    @State private var model: EmergencyModel = EmergencyModel()
    var body: some View {
        VStack {
            NavigationLink {
                EmergencyView(model: $model)
                    .onAppear {
                        model.startTimer()
                        model.audioModel.toggleActive()
                    }
                    .onDisappear(perform: {
                        model.audioModel.toggleActive()
                        model.startTimer()
                    })
            } label: {
                Label("Emergency", systemImage: "waveform.path.ecg")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .padding()
                    .padding(.vertical,20)
                    .background {
                        ZStack{
                            Color.red
                            WornOutTextureView()
                        }
                    }
                    .borderedBackground()
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    NavigationStack{
        MainView()
    }
}
