//
//  EmergencyCheck.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///View for the ``EmergencyChecklistView`` , one list item
struct EmergencyCheck:View {
    
    var check:String
    @State private var isChecked:Bool = false
    var isCheck:Bool
    
    var body: some View {
        HStack{
            Text(check)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            Spacer()
            Image(systemName: isChecked ? isCheck ? "checkmark.circle" : "xmark.circle" : "circle")
                .font(.title2)
                .bold()
                .if(isChecked) { view in
                    view.symbolRenderingMode(.palette)
                        .foregroundStyle(isCheck ? Color.green : Color.red, Color.primary)
                }
        }
        .overlay(content: {
            Rectangle().foregroundStyle(Color.black.opacity(0.01))
        })
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

#Preview {
    EmergencyCheck(check: "Cleared airways",isCheck: false)
}
