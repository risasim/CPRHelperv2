//
//  PracticeChooseLogic.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import Foundation
import SwiftUI

///All of the practice options
enum PracticeOptions:Codable {
    case history,how,positionTrain,rhytmTrain
    
    func title() -> String {
        switch self {
        case .history: return "History"
        case .how: return "How to perform CPR"
        case .positionTrain: return "Where to do CPR"
        case .rhytmTrain: return "CPR rhytm training"
        }
    }
    
    func destination(_ isActive:Binding<PracticePage?>) ->any View {
        switch self {
        case .history: return HistoryView()
        case .how: return HowToCPR()
        case .positionTrain: return PlaceChestTraining(isActive: isActive)
        case .rhytmTrain: return FrequencyView()
        }
    }
    
    func icon()->String{
        switch self {
        case .history: return "book.circle"
        case .how: return "questionmark.circle"
        case .positionTrain: return "mappin.and.ellipse"
        case .rhytmTrain: return "waveform.path.ecg"
        }
    }
}

///One practice page that will be saved, defined by the ``PracticeOptions``
struct PracticePage: Identifiable,Codable{
    var id:UUID
    var type: PracticeOptions
    var isComplete: Bool = false
    
    init(type: PracticeOptions) {
        self.id = UUID()
        self.type = type
    }
}

///Array of PracticePages for simpler saving via JSON
struct PracticePages:Codable{
    var pages: [PracticePage] = []
}

///Struct for handling the saving and reading of the ``PracticePages``
struct PracticePagesHandler{
    var pages: PracticePages=PracticePages()
    
    init(){
        self.pages = PracticePagesHandler.loadFromDefaults()
    }
    
    mutating func toggle(pageId: UUID){
        if let index = pages.pages.firstIndex(where: { $0.id == pageId }){
            pages.pages[index].isComplete = true
            saveToDefaults()
        }
    }
    
    func saveToDefaults() {
        let defaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pages) // Serialize to JSON
            defaults.set(data, forKey: OPTIONS_KEY)
        } catch {
            print("Failed to save PracticePages to UserDefaults: \(error)")
        }
    }
    
    func isLast(id:UUID) -> Bool{
        return pages.pages.last!.id==id
    }
    
    static func loadFromDefaults() -> PracticePages{
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: OPTIONS_KEY) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(PracticePages.self, from: data)
            } catch {
                print("Failed to load PracticePages from UserDefaults: \(error)")
            }
        }
        var defaultpages = PracticePages()
        defaultpages.pages.append(contentsOf: [PracticePage(type: PracticeOptions.history),PracticePage(type: PracticeOptions.how),PracticePage(type: PracticeOptions.rhytmTrain),PracticePage(type: PracticeOptions.positionTrain)])
        return defaultpages
    }
}
