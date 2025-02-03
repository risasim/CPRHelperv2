//
//  EmergencyChecklist.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Chesklist of what should be done in case you are found in situtation with need of CPR
struct EmergencyChecklistView:View {
    var body: some View {
        VStack{
            EmergencyCheck(check: checklist[0], isCheck: true)
            Divider()
            EmergencyCheck(check: checklist[1], isCheck: false)
            Divider()
            EmergencyCheck(check: checklist[2], isCheck: false)
            Divider()
            EmergencyCheck(check: checklist[3], isCheck: true)
            Divider()
            EmergencyCheck(check: checklist[4], isCheck: true)
                .padding(.bottom)
        }
        .padding(.horizontal,3)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding(.top)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1))
        )
        .padding(.leading,5)
    }
}

#Preview {
    EmergencyChecklistView()
}
