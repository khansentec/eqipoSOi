//
//  Health Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation
import Firebase

class HealthReport: Identifiable {
    var save = FirebaseViewController()
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
            save.deleteOldRemindByType(type: "reporteSalud", date: Date.now)
            save.saveData(collectionName: "reportesSalud", id: id, info: info){(done)
                in
                if done{
                    let id = UUID().uuidString
                    var nextReportDate = Calendar.current.date(byAdding: DateComponents(day: 7), to: self.date)!
                    
                    
                    let info : [String: Any] = ["id": id, "idPaciente": idUser, "fecha":nextReportDate, "tipo":"reporteSalud","titulo":"Próximo Reporte Salud", "descripcion":"Próximo Reporte Salud"]
                    self.save.saveData(collectionName: "notificaciones", id: id, info: info){
                        (done)in
                        if done{
                            print("Succesfully upload reminder of type week report")
                        }else{
                            print("ERROR saving info")
                        }
                    }
                }else{
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                }
            }
            
        }
        return (healthRUploaded, alertTitle, alertMessage)
    }
    
    
    
}
