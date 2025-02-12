//
//  AnimatedAppLabel.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

/// View to show the animated title on every intro in the app
struct AnimatedAppLabel: View {
    let appName: String
    @State private var crossOffset: CGFloat = 0
    @State private var textRevealWidth: CGFloat = 0

    // Prevents animation from running every time
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("performAnimation") var performAnimation: Bool = true

    private var textWidth: CGFloat {
        CGFloat(appName.count * 16)
    }

    var body: some View {
        ZStack(alignment: .center) {
            Text(appName)
                .bold()
                .font(.title2)
                .fixedSize()
                .mask(
                    GeometryReader { geometry in
                        Rectangle()
                            .size(width: textRevealWidth, height: geometry.size.height)
                            .offset(x: geometry.size.width - textRevealWidth)
                    }
                )
                // Offset text to make room for the icon
                .offset(x: 0)
            
            RoundedEdgeCrossShape()
                .offset(x: crossOffset)
                .foregroundColor(.red)
                .padding(.top, 3)
        }
        .frame(width: textWidth + 15, height: 0, alignment: .center)
        .padding(.leading, 27)
        .onAppear {
            if performAnimation {
                resetAnimation()
                runAnimation()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                performAnimation = true  // Ensure animation can run when app becomes active
            }
        }
        .onChange(of: performAnimation) { newValue in
            if newValue {
                resetAnimation()
                runAnimation()
            }
        }
    }

    /// Resets animation state to ensure a fresh start
    private func resetAnimation() {
        textRevealWidth = 0
        crossOffset = (textWidth + 30) / 2
    }

    /// Runs the swipe animation to reveal the name
    private func runAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            crossOffset = textWidth + 20 // Move cross to the end
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 1.5)) {
                crossOffset = -8 // Move cross to the left side
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.smooth(duration: 1.5)) {
                        textRevealWidth = textWidth + 5 // Reveal text from right to left
                    }
                }
            }
        }
    }
}


#Preview {
    MainView()
}

///Custom shape for the cross at the app title
struct RoundedEdgeCrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = 20.0
        let height = 20.0
        let lineWidth: CGFloat = min(width, height) / 2.5
        let halfLineWidth = lineWidth / 4

        // Horizontal line
        let horizontalRect = CGRect(x: 0, y: (height - lineWidth) / 2, width: width, height: lineWidth)
        path.addPath(Path(roundedRect: horizontalRect, cornerRadius: halfLineWidth))

        // Vertical line
        let verticalRect = CGRect(x: (width - lineWidth) / 2, y: 0, width: lineWidth, height: height)
        path.addPath(Path(roundedRect: verticalRect, cornerRadius: halfLineWidth))

        return path
    }
}
