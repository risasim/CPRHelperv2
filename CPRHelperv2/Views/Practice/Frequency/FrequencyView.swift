//
//  FrequencyView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI
import Charts

///Main view of the "simulation", shows all of the data
struct FrequencyView: View {
    @StateObject var model:FreqModel = FreqModel()
    @State private var animateShow = false
    @State private var animateFade = false
    @State private var sheetContentHeight = CGFloat(0)
    @State private var disabled = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Time: "+String(Int(60.0-model.secs)))
                //Text(String(model.avgOfLastTwo))
                HStack{
                    ZStack{
                        GaugeView(curFreq: $model.averageSoFar)
                            .opacity(0)
                        FreqSpeedView(value: $model.avgOfLastTwo,status: $model.stat)
                            .padding(.leading,animateShow ? 20 : 0)
                    }
                    if(animateShow){
                        HStack{
                            Spacer()
                            GaugeView(curFreq: $model.averageSoFar)
                                .padding(.bottom,18)
                        }
                        .opacity(animateFade ? 1.0 : 0.0)
                        .transition(.slide)
                    }
                }
                .padding(.bottom,25)
                Text("Last push at cadence: \(model.lastFreq)")
                Button {
                    model.push()
                } label: {
                    Text(model.started ?"Resuscitate" :"Start")
                        .font(.title)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 90)
                        .stroke(style: StrokeStyle(lineWidth: 3))
                )
                .disabled(disabled)
                .buttonStyle(.bordered)
                    .tint(model.started ? Color.red: Color.blue)
                    .accessibilityIdentifier("PushResusctiateButton")
                
            }
            .padding()
            .onChange(of: model.show) { oldValue, newValue in
                withAnimation {
                    animateShow = newValue
                }
                withAnimation(.easeIn.delay(0.15)) {
                    animateFade = newValue
                }
            }
            .onChange(of: model.started, { oldValue, newValue in
                if(!newValue){
                    disabled = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        disabled = false
                    }
                }
            })
            .sheet(isPresented: $model.showResults) {
                FinalResView(showResults: $model.showResults, data: model.avgsPerSeconds, curFreq: model.averageSoFar)
                    .background {
                        //This is done in the background otherwise GeometryReader tends to expand to all the space given to it like color or shape.
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents([.height(sheetContentHeight),.height(sheetContentHeight+60.0)])
            }
        }
    }
}

#Preview {
    FrequencyView()
}
