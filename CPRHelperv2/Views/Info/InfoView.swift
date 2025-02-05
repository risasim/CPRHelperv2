//
//  InfoView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Info slide about the author and maybe some Info
struct InfoView: View {
    
    @Binding var active:Bool
    @AppStorage("emergencyNumber") var number:String = "911"
    
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
                        .padding([.top,.trailing])
                })
            }
            GroupBox {
                HStack(alignment: .center, spacing: 10){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(9)
                    Text("CPR Helper is an app that teaches CPR through simulations. Designed for the Swift Student Challenge 2025, it features step-by-step guidance and an emergency button to prepare users for real-life situations.")
                        .font(.footnote)
                }
            } label: {
                InfoLabelView(label: "CPR Helper", image: "info.circle")
            }
            .borderedBackground()
            .padding(.top, 10)
            GroupBox {
                Divider().overlay(.primary).padding(.vertical, 4)
                HStack{
                    Text("Emergency phone number")
                        .foregroundColor(.gray)
                    Spacer()
                    Picker("set.linkLang", selection: $number) {
                        ForEach(phoneNumbers, id: \.self) { num in
                            Text(num)
                                .tag(num)
                        }
                    }
                }
            } label: {
                InfoLabelView(label: "Settings", image: "gear")
            }.borderedBackground()
            GroupBox(content: {
                InfoRowView(label: "Developer", description: "Richard Šimoník")
                InfoRowView(label: "Compability", description: "iOS 18")
                InfoRowView(label: "Instagram", linkLabel: "@risasimonik", linkDestination: "instagram.com/risasimonik")
                InfoRowView(label: "X", linkLabel: "@richiesimonik", linkDestination: "twitter.com/richiesimonik")
                InfoRowView(label: "SwiftUI", description: "6.0")
                InfoRowView(label: "App version",description: "0.9")
            }, label: {
                InfoLabelView(label: "About app", image: "apps.iphone")
            }).borderedBackground()
        }
        .padding(.horizontal)
        Spacer()
    }
}

#Preview {
    InfoView(active: .constant(true))
}

#Preview {
    MainView()
}
