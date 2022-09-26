//
//  Medic.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import Foundation

struct Medic : Hashable, Identifiable{
    /*paciente/medico*/
    var correo: String
    var apellidoPaterno: String
    var apellidoMaterno: String
    var nombre: String
    var foto: String
    var id: String
    var cedulaProfesional: String
}

