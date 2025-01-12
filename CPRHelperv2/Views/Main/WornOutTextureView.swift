//
//  WornOutTextureView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Texture for the emergency button in the ``MainView```
struct WornOutTextureView: View {
    var color: Color = .white
    var baseIntensity: Double = 0.3
    var scratchCount: Int = 200
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                for _ in 0..<scratchCount {
                    let startX = CGFloat.random(in: 0...size.width)
                    let startY = CGFloat.random(in: 0...size.height)
                    let length = CGFloat.random(in: 5...30)
                    let angle = CGFloat.random(in: 0...(2 * .pi))
                    
                    let endX = startX + length * cos(angle)
                    let endY = startY + length * sin(angle)
                    
                    var path = Path()
                    path.move(to: CGPoint(x: startX, y: startY))
                    path.addLine(to: CGPoint(x: endX, y: endY))
                    
                    let intensity = Double.random(in: 0.1...1.0) * baseIntensity
                    let lineWidth = CGFloat.random(in: 0.5...2.0)
                    
                    context.stroke(path, with: .color(color.opacity(intensity)), lineWidth: lineWidth)
                    
                    // Add some shorter connecting scratches
                    if Bool.random() {
                        let midX = (startX + endX) / 2
                        let midY = (startY + endY) / 2
                        let shortLength = CGFloat.random(in: 2...10)
                        let shortAngle = angle + .pi/2 + CGFloat.random(in: -0.5...0.5)
                        
                        let shortEndX = midX + shortLength * cos(shortAngle)
                        let shortEndY = midY + shortLength * sin(shortAngle)
                        
                        var shortPath = Path()
                        shortPath.move(to: CGPoint(x: midX, y: midY))
                        shortPath.addLine(to: CGPoint(x: shortEndX, y: shortEndY))
                        
                        context.stroke(shortPath, with: .color(color.opacity(intensity * 0.7)), lineWidth: lineWidth * 0.7)
                    }
                }
            }
        }
    }
}
