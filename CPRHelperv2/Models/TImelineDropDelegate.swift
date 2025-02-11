//
//  TImelineDropDelegate.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import Foundation
import SwiftUI

///DropDeleagate for ``CPRTimelineView`` that handles the reordering the timeline
struct TImelineDropDelegate: DropDelegate {
    
    let destinationItem: CPRStep
    @Binding var items: [CPRStep]
    @Binding var draggedItem: CPRStep?
    
    //Handles the drop
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    //Does the acutal drop
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    //Puts the moved step in the right position
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            let fromIndex = items.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = items.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
