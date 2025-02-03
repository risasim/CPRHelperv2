//
//  AnimatedAppLabel.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///View to show the animted title on every intro in the app
struct AnimatedAppLabel: View {
    let appName: String
    @State private var crossOffset: CGFloat = 0
    @State private var textRevealWidth: CGFloat = 0
    
    //So it doesnt animate every time
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("performAnimation") var performAnimation:Bool = true
    
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
                .offset(x: 0) // Offset text to make room for the icon
            RoundedEdgeCrossShape()
                .offset(x: crossOffset)
                .foregroundColor(.red)
                .padding(.top,3)
        }
        .frame(width: textWidth + 15, height: 0, alignment: .center)
        .padding(.leading, 27)
        .onAppear {
            if(performAnimation){
                runAnimation()
            }
        }
        .onChange(of: scenePhase) {
            print(scenePhase)
            if scenePhase == .inactive {
                performAnimation = false
            } else if scenePhase == .active {
                performAnimation = false
            } else if scenePhase == .background {
                performAnimation = true
            }
        }
        .onChange(of: performAnimation) {
            if performAnimation{
                runAnimation()
            }
        }
    }
    ///Create the swipe animtaion to reveal the name
    func runAnimation(){
        // Start cross at the center
        crossOffset = (textWidth + 30) / 2
        
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
