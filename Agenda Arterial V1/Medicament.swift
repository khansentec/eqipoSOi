//
//  Medicament.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import Foundation

struct Medicament : Hashable, Identifiable {
    var id = UUID()
    var idPaciente : String
    var nombreMedicamento : String
    var informacion : String
    var fechaInicio : Date
    var vecesOlvidado : Int
    }
    
    
extension Medicament {
    static let medicamentosList = [
        Medicament(idPaciente: "1234", nombreMedicamento: "Paracetamol", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
        Medicament(idPaciente: "1234", nombreMedicamento: "Tempra", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
        Medicament(idPaciente: "1234", nombreMedicamento: "Sulfas", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0)
        
    ]
}
