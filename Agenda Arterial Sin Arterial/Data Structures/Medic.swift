//
//  Medic.swift
//  Agenda Arterial V1
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
    var phone: String

    init(id: String?, name: String, patName: String, matName: String, email: String, foto: String, proflicense: String, phone: String){
        self.id = id ?? ""
        self.email = email
        self.patName = patName
        self.matName = matName
        self.name = name
        self.photo =  foto
        self.proflicense = proflicense
        self.phone = phone
    }
}
