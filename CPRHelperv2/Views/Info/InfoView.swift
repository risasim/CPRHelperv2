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
                        .padding(.top)
                })
            }
            GroupBox {
                HStack(alignment: .center, spacing: 10){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(9)
                    Text("InfoView.info")
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
                    Text("InfoView.emergencyNumber")
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
                InfoLabelView(label: "InfoView.settings", image: "gear")
            }.borderedBackground()
            GroupBox(content: {
                InfoRowView(label: "InfoView.developer", description: "Richard Šimoník")
                InfoRowView(label: "InfoView.compatibility", description: "iOS 18")
                Divider()
                InfoRowView(label: "Instagram", linkLabel: "@risasimonik", linkDestination: "instagram.com/risasimonik")
                InfoRowView(label: "X", linkLabel: "@richiesimonik", linkDestination: "twitter.com/richiesimonik")
                InfoRowView(label: "SwiftUI", description: "6.0")
                InfoRowView(label: "InfoView.appVersion",description: "1.0.1")
            }, label: {
                InfoLabelView(label: "InfoView.aboutApp", image: "apps.iphone")
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
