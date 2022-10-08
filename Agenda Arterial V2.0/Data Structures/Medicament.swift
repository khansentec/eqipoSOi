//
//  Medicament.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import Foundation

struct Medicament : Identifiable, Hashable {
    var id : String
    var medicamentName : String
    var information : String
    var startDate : Date
    var finishDate : Date
    var forgetTimes : Int

    init(id: String?, medicamentName: String, information: String, startDate: Date, finishDate: Date, forgetTimes: Int){
        self.id = id ?? ""
        self.medicamentName = medicamentName
        self.information = information
        self.startDate = startDate
        self.finishDate = finishDate
        self.forgetTimes = forgetTimes
    }
    
}



    
extension Medicament {
    static let medicamentosList = [
        Medicament(id: "12", medicamentName: "Paracetamol", information: "sjhf", startDate: Date.now, finishDate: Date.now,forgetTimes: 12)
        
    ]
}