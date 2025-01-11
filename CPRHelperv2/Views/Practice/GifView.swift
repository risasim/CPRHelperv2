//
//  GIfView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct GIFView: View {
    var body: some View {
        let localGifURL = Bundle.main.url(forResource: "heartgif", withExtension: "gif")!
        WebView(url: localGifURL)
            .frame(width: 300, height: 250) // Adjust size as needed
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 1))
            )
    }
}

#Preview {
    GIFView()
}
