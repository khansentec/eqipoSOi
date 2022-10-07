//
//  Medicament.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import Foundation

struct Medicament : Hashable, Identifiable {
    var id = UUID()
    var idPacient : String
    var medicamentName : String
    var information : String
    var startDate : Date
    var forgetTimes : Int
    }
    
extension Medicament {
    static let medicamentosList = [
        Medicament(idPacient: "1234", medicamentName: "Paracetamol", information: "sjhf", startDate: Date.now, forgetTimes: 12)
        
    ]
}
