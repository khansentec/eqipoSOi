//
//  MeditionRecord.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 17/10/22.
//

import Foundation

struct MeditionRecord :  Hashable, Identifiable{
    var id : String
    var date : Date
    var state : String
    var pressureInf: Int
    var pressureSup : Int
    var pulse : Int
}
