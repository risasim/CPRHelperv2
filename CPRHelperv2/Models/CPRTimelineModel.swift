//
//  CPRTimeline.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.02.2025.
//

import Foundation
import SwiftUI


///One Cpr step used in timeline
struct CPRStep: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var correctOrder: Int
}

///Model that handles the timeline of steps that are used in CPR
@Observable
class CPRTimelineModel{
    private static let items: [CPRStep] = [
        CPRStep(name: "Check the Scene", correctOrder: 0),
        CPRStep(name: "Check Responsiveness", correctOrder: 1),
        CPRStep(name: "Call for Help", correctOrder: 2),
        CPRStep(name: "Check for Breathing", correctOrder: 3),
        CPRStep(name: "Open the Airway", correctOrder: 4),
        CPRStep(name: "Give Chest Compressions", correctOrder: 5),
        CPRStep(name: "Rescue Breaths (if trained)", correctOrder: 6),
        CPRStep(name: "Use an AED (if available)", correctOrder: 7),
        CPRStep(name: "Continue CPR", correctOrder: 8)
    ]
    
    var viewSteps: [CPRStep]
    
    init() {
        self.viewSteps = CPRTimelineModel.items.shuffled()
    }
    
    /// Function to sort items by correct order
    func sortItems() {
        viewSteps.sort { $0.correctOrder < $1.correctOrder }
    }
   
    ///Checks the order of the steps
    func checkOrder() -> Bool{
        for i in 0..<viewSteps.count{
            if(viewSteps[i].correctOrder != i){
                return false
            }
        }
        return true
    }
    
    func reset(){
        viewSteps = CPRTimelineModel.items.shuffled()
    }
}
