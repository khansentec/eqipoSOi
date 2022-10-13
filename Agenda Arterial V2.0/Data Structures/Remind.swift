//
//  Remind.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import Foundation

struct Remind :  Hashable, Identifiable {
    var id : String
    var date : Date
    var type : String
    var title : String
    var description : String
    var color : String
}
