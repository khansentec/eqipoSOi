//
//  Medicament.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import Foundation

struct Medicament : Hashable, Identifiable {
    var id : String
    var idPacient : String
    var medicamentName : String
    var information : String
    var startDate : Date
    var finishDate : Date
    var forgetTimes : Int
}


