//
//  SourceOfInfo.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 28.03.2025.
//

import SwiftUI

struct SourceOfInfo: View {
    var body: some View {
        Link(destination: URL(string: "https://www.redcross.org/take-a-class/cpr/performing-cpr/cpr-steps?srsltid=AfmBOooYpIeRwMV7uqeE4YAeLMPfA9W7YywRHuKvaCY9AwXmpG2R0vji")!) {
            Label("Source of information (Red Cross)", systemImage: "link")
        }
    }
}

#Preview {
    SourceOfInfo()
}
