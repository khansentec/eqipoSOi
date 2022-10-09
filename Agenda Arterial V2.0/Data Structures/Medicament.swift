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
/*
    func validateMedicament() -> (Bool, String){
        if self.medicamentName == ""{
            return(false, "Favor de ingresar el nombre del medicamento")
        }
    }

    func uploadMedicament() -> (Bool, String, String){
        let validationResults = self.validateMedicament()
            
        var medIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var medUploaded = false
            
        if medIsValid {
            //método para subir a firebase regresa booleano
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
                    medUploaded = true
                }else{
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                }
            }
                
        } 
        return (medUploaded, alertTitle, alertMessage)
    }
    
    func updateMedicament(startDate: Date, finishDate : Date, information: String, active: Bool) -> (Bool, String, String){
        let validationResults = self.validateMedicament()
            
        var medIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var medUploaded = false
            
        if medIsValid {
            
            let info : [String: Any] = ["fechaInicio":startDate, "fechaDesactivacion":finishDate, "informacion": information, "activo": active]
  
            loginShow.updateData(collectionName: "medicamentos", id: self.id, info: info){(done)
                in
                if done{
                    alertTitle = "¡Éxito!"
                    alertMessage = "Los datos se han guardado correctamente"
                    medUploaded = true
                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    medUploaded = false

                }
            }
                
        } 
        return (medUploaded, alertTitle, alertMessage)
    }
    */
}

    
extension Medicament {
    static let medicamentosList = [
        Medicament(id: "12", medicamentName: "Paracetamol", information: "sjhf", startDate: Date.now, finishDate: Date(),forgetTimes: 12)
        
    ]
}