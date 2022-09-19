//
//  MedicamentoClass.swift
//  ProyectoSOi
//
//  Created by alumno on 19/09/22.
//

import Foundation

struct Medicamento : Hashable, Identifiable {
    var id = UUID()
    var idPaciente : String
    var nombreMedicamento : String
    var informacion : String
    var fechaInicio : Date
    var vecesOlvidado : Int
    }
    
extension Medicamento {
    static let medicamentosList = [
        Medicamento(idPaciente: "1234", nombreMedicamento: "Paracetamol", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
        Medicamento(idPaciente: "1234", nombreMedicamento: "Tempra", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
        Medicamento(idPaciente: "1234", nombreMedicamento: "Sulfas", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0)
        
    ]
}
