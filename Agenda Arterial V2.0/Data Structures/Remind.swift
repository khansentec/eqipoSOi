//
//  Remind.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import Foundation

class Remind : Identifiable {
    var id = UUID()
    var date : String
    var events : [String]
    
    init(date : String, events: [String]) {
        self.date = date
        self.events = events
    }
}
