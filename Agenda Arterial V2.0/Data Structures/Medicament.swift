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
    var active : Bool

    init(id: String?, medicamentName: String, information: String, startDate: Date, finishDate: Date?, forgetTimes: Int?, active : Bool?){
        self.id = id ?? ""
        self.medicamentName = medicamentName
        self.information = information
        self.startDate = startDate
        self.finishDate = finishDate ?? startDate
        self.forgetTimes = forgetTimes ?? 0
        self.active = active ?? true
    }
    
}

/*

let id = UUID().uuidString

guard let idUser = Auth.auth().currentUser?.uid else{
    return (false, alertTitle, "Usuario no encontrado")
}

let info : [String: Any] = ["id": id,"idPaciente":idUser,"fechaInicio":self.startDate, "fechaDesactivacion":self.finishDate,  "nombreMedicamento": self.medicamentName, "informacion": self.information, "activo": self.active, "vecesOlvidado": self.forgetTimes]
     
loginShow.saveData(collectionName: "medicamentos", id: id, info: info){(done)
            in
                if done{
                    alertTitle = "¡Éxito!"
                    alertMessage = "Los datos se han guardado correctamente"
                    meditionUploaded = true
                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    meditionUploaded = false

                }
            }

*/

    
extension Medicament {
    static let medicamentosList = [
        Medicament(id: "12", medicamentName: "Paracetamol", information: "sjhf", startDate: Date.now, finishDate: Date.now,forgetTimes: 12)
        
    ]
}