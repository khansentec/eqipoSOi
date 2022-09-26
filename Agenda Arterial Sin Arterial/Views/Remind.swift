//
//  Remind.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import Foundation

class Remind : Identifiable {
    var id = UUID()
    var fecha : String
    var eventos : [String]
    
    init(fecha : String, eventos: [String]) {
        self.fecha = fecha
        self.eventos = eventos
    }
}
