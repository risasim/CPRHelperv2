//
//  CPRTimelinView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import SwiftUI

///CPR timlie on which the users will train the correct order of the steps during CPR
struct CPRTimelineView: View {
    @State private var timelineModel = CPRTimelineModel()
    @State private var draggedItem: CPRStep?
    @State private var showFeedback = false
    @State private var isCorrect = false
    @Binding var activeView:PracticePage?
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                Text("Drag the steps to correct order:")
                Spacer()
            }
            .font(.headline)
            ForEach(Array(timelineModel.viewSteps.enumerated()), id: \.element.id) { index, item in
                CPRStepView(index: index, item: $timelineModel.viewSteps[index])
                    .onDrag {
                        self.draggedItem = item
                        return NSItemProvider()
                    }
                    .onDrop(
                        of: [.text],
                        delegate: TImelineDropDelegate(
                            destinationItem: item,
                            items: $timelineModel.viewSteps,
                            draggedItem: $draggedItem
                        )
                    )
            }
            .alert(isPresented: $showFeedback) {
                if(isCorrect){
                    Alert(
                        title: Text("Correct!"),
                        message: Text("You've identified the correct area for CPR."),
                        primaryButton: .default(Text("Go back")){
                            activeView = nil
                        },
                        secondaryButton: .default(Text("Try Again")) {
                            timelineModel.reset()
                        }
                    )
                }else{
                    Alert(
                        title: Text("Not quite right"),
                        message: Text("Look again and try to picture the situation in your mind and what order would you do the steps."),
                        dismissButton: .default(Text("Try Again")) {
                            showFeedback = false
                        }
                    )
                }
                
            }
            Spacer()
            Button {
                isCorrect = timelineModel.checkOrder()
                showFeedback = true
            } label: {
                Text("Check")
                    .padding()
                    .borderedBackground()
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CPRTimelineView(activeView: .constant(PracticePage.init(type: PracticeOptions.history)))
        .fontDesign(.monospaced)
}
