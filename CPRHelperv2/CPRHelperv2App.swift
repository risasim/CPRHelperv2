//
//  CPRHelperv2App.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

let OPTIONS_KEY = "options"

@main
struct CPRHelperv2App: App {
    @AppStorage("opened") var opened: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                MainView()
                if(!opened){
                    OnBoardingsView()
                }
            }
        }
    }
}
