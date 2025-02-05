//
//  InfoRowView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

struct InfoRowView: View {
    
    var label: String
    var description: String? = nil
    var linkLabel:String? = nil
    var linkDestination : String? = nil
    
    var body: some View {
        VStack {
            //TODO change color ot primary
            Divider().overlay(.primary).padding(.vertical, 4)
            HStack{
                Text(LocalizedStringKey(label))
                    .foregroundColor(.gray)
                Spacer()
                if description != nil {
                    Text(description!)
                } else if linkLabel != nil && linkDestination != nil{
                    Link( linkLabel! ,destination: URL(string: "http://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.blue)
                }else {
                    EmptyView()
                }
                
            }
        }
    }
}

#Preview {
    InfoRowView(label: "Version", description: "0.8")
}
