//
//  EmergencyView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Main view for emergency, showing all of the stuff 
struct EmergencyView: View {
    
    @Binding var model:EmergencyModel
    
    var body: some View {
        VStack{
            PulsingView(time: $model.timeLabel,audio: $model.audioModel)
                .padding(.horizontal,5)
            HStack{
                EmergencyChecklistView()
                CallView()
                    .onTapGesture {
                        model.callNumber()
                    }
            }
            .frame(maxHeight: 250)
            Text("Resuscitate until the ambulance arrive")
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding(.horizontal,20)
        }
        .onAppear(perform: {
            increaseVolume()
        })
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Keep yourself safe")
                    .bold()
            }
        })
    }
}

#Preview {
    NavigationStack{
        EmergencyView(model: .constant(EmergencyModel()))
    }
}
