//
//  PracticeChooseLogic.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import Foundation

enum PracticeOptions:Codable {
    case what,how,positionTrain,rhytmTrain
    
    func title() -> String {
        switch self {
        case .what: return "What"
        case .how: return "How"
        case .positionTrain: return "Position training"
        case .rhytmTrain: return "Rhytm training"
        }
    }
}


struct PracticePage: Identifiable,Codable{
    var id:UUID
    var type: PracticeOptions
    var isComplete: Bool = false
    
    init(type: PracticeOptions) {
        self.id = UUID()
        self.type = type
    }
}

struct PracticePages:Codable{
    var pages: [PracticePage] = []
}

struct PracticePagesHandler{
    var pages: PracticePages=PracticePages()
    
    init(){
        self.pages = PracticePagesHandler.loadFromDefaults()
    }
    
    mutating func toggle(pageId: UUID){
        if let index = pages.pages.firstIndex(where: { $0.id == pageId }){
            pages.pages[index].isComplete.toggle()
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
        defaultpages.pages.append(contentsOf: [PracticePage(type: PracticeOptions.how),PracticePage(type: PracticeOptions.what),PracticePage(type: PracticeOptions.rhytmTrain),PracticePage(type: PracticeOptions.positionTrain)])
        return defaultpages
    }
}
