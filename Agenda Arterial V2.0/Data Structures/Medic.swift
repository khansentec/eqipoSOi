//
//  Medic.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import Foundation

struct Medic : Identifiable, Hashable {
    /*paciente/medico*/
    var id: String
    var email: String
    var patName: String
    var matName: String
    var name: String
    var photo: String 
    var proflicense: String

    init(id: String?, name: String, patName: String, matName: String, email: String, foto: String, proflicense: String){
        self.id = id ?? ""
        self.email = email
        self.patName = patName
        self.matName = matName
        self.name = name
        self.photo =  foto
        self.proflicense = proflicense
    }
}
