//
//  GaugeView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

///Showing the estimated final frequency of the user.
struct GaugeView: View {
    
    @Binding var curFreq:Int
    
    var body: some View {
        VStack{
            Text("Estimation of final push/min")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.vertical, 30)
            Gauge(value: Float(curFreq),in: 80...140) {
                Text("Hello")
            } currentValueLabel: {
                Text(String(curFreq))
            } minimumValueLabel: {
                Text(String(70))
            } maximumValueLabel: {
                Text(String(150))
            }
            .tint(Gradient(colors: [.red,.green, .green,.red]))
            .gaugeStyle(.accessoryCircular)
            .scaleEffect(2)
        }
    }
}

#Preview {
    GaugeView(curFreq: .constant(110))
}

