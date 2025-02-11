//
//  CPRTimelinView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import SwiftUI

struct CPRTimelineView: View {
    
    @State private var timelineModel = CPRTimelineModel()
    @State var draggedItem: CPRStep?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
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
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(Color.black)
    }
}

#Preview {
    CPRTimelineView()
}
