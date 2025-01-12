//
//  InfoView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Info slide about the author and maybe some settings
struct InfoView: View {
    
    @Binding var active:Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {active.toggle()}, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.primary)
                        .bold()
                        .font(.title)
                        .fontDesign(.monospaced)
                        .padding()
                })
            }
        }
        Spacer()
    }
}

#Preview {
    InfoView(active: .constant(true))
}

#Preview {
    MainView()
}
