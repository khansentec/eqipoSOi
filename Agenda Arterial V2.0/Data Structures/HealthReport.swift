//
//  Health Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class HealthReport: Identifiable {
    var id : String
    var feeling : Float
    var symptomsPresent : Bool
    var symptoms : String
    var comments : String
    var date : Date

    init(id: String?, feeling : Float, symptomsPresent : Bool, symptoms : String, comments : String){
        self.id = id ?? ""
        self.feeling = feeling
        self.symptoms = symptoms
        self.symptomsPresent = symptomsPresent
        self.comments = comments
        self.date = Date()
    }

    func validateHR() -> (Bool, String){
        if self.comments == ""{
            self.comments = "N/A"
        }

        if self.symptomsPresent && self.symptoms == ""{
            return (false, "Favor de indicar sus sintomas")
        }else{
            if !self.symptomsPresent {
                self.symptoms = "N/A"
            }
            return (true, "Datos válidos")
        }
    }

    func uploadHR() -> (Bool, String, String){
        let validationResults = self.validateHR()

        var reportIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var healthRUploaded = false


        if reportIsValid {
            //método para subir a firebase regresa booleano
            let id = UUID().uuidString
        
            guard let idUser = Auth.auth().currentUser?.uid else{
                return (false, alertTitle, "Usuario no encontrado")
            }
            let info : [String: Any] = ["id": id, "idPaciente": idUser,"fecha":self.date, "estadoSalud":self.feeling,  "sintomasPresentes": self.symptomsPresent, "sintomas":self.symptoms, "comentariosAdicionales":self.comments]
        
            loginShow.saveData(collectionName: "reportesSalud", id: id, info: info){(done)
                in
                    if done{
                        var nextReportDate = Calendar.current.date(byAdding: DateComponents(day: 7), to: self.date)!
                        var newRemind = Remind(date: nextReportDate, type: "reporteSalud", title: "Próximo Reporte Salud", description: "Llena tu reporte de salud", color : "Color.green")
                        
                        var remindsUpdated = newRemind.updateRemind()

                        if remindsUpdated {
                            alertTitle = "¡Éxito!"
                            alertMessage = "Los datos se han guardado correctamente"
                            healthRUploaded = true

                        }else {
                            alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                        }
                                    
                    }else{
                        alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    }
            }

        }
        return (healthRUploaded, alertTitle, alertMessage)
    }



}