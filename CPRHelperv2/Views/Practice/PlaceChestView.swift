//
//  PlaceChestView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI
///View for training the place whrer CPR should be done
struct PlaceChestView: View {
    @State private var tappedPoint: CGPoint?
    @State private var showFeedback = false
    @State private var isCorrect = false
    @Binding var activeView:PracticePage?
    
    let correctArea = CGRect(x: 0.45, y: 0.4, width: 0.1, height: 0.1)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("chest")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.8)
                    .foregroundColor(.gray)
                
                if let point = tappedPoint {
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(isCorrect ? Color.green : Color.red)
                        .position(point)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { location in
                self.tappedPoint = location
                self.isCorrect = self.checkTappedLocation(location, in: geometry.size)
                self.showFeedback = true
            }
            .alert(isPresented: $showFeedback) {
                if(isCorrect){
                    Alert(
                        title: Text("Not quite right"),
                        message: Text("The correct area for CPR is in the center of the chest, between the nipples."),
                        primaryButton: .default(Text("Go back")){
                            activeView = nil
                        },
                        secondaryButton: .default(Text("Try Again")) {
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                                self.tappedPoint = nil
                            }
                        }
                    )
                }else{
                    Alert(
                        title: Text("Correct!"),
                        message: Text("You've identified the correct area for CPR."),
                        dismissButton: .default(Text("Try Again")) {
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                                self.tappedPoint = nil
                            }
                        }
                    )
                }
                
            }
        }
    }
    
    func checkTappedLocation(_ point: CGPoint, in size: CGSize) -> Bool {
        let relativeX = point.x / size.width
        let relativeY = point.y / size.height
        return correctArea.contains(CGPoint(x: relativeX, y: relativeY))
    }
}

#Preview {
    PlaceChestView(activeView: .constant(PracticePage(type: .history)))
}
