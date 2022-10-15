//
//  Appointment Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation
import Firebase

class Appointment: Identifiable {
    var login = FirebaseViewController()
    var id : String
    var date : Date
    var idMedic : String
    var comments : String

    init(id : String?, date: Date, idMedic : String, comments : String){
        self.id = id ?? ""
        self.date = date
        self.idMedic = idMedic
        self.comments = comments
    }

    func validateAppointment() -> (Bool, String){
        if self.idMedic == "Sin seleccionar"{
            return (false, "Favor de seleccionar un médico")
        }
        if self.comments == ""{
            self.comments = "N/A"
        }
        return (true, "Datos válidos")

    }

    func uploadAppointment() -> (Bool, String, String){
        let validationResults = self.validateAppointment()
        var appIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var appointUploaded = false
            
        if appIsValid {
            //método para subir a firebase regresa booleano
            let id = UUID().uuidString
        
            guard let idUser = Auth.auth().currentUser?.uid else{
                return (false, alertTitle, "Usuario no encontrado")
            }
            
            let info : [String: Any] = ["id": id, "idPaciente": idUser,"fecha": self.date, "idMedico": self.idMedic,  "comentario": self.comments]

            login.saveData(collectionName: "consultas", id: id, info: info){(done)
                in
                if done{
                    var remindsUpdated = false
                    for n in 1...5 {
                        let id = UUID().uuidString
                        let nextMeditionDate = Calendar.current.date(byAdding: DateComponents(day: -n), to:self.date)!
                        if nextMeditionDate > Date(){
                            let info : [String: Any] = ["id": id, "idPaciente": idUser, "fecha":nextMeditionDate, "tipo":"medicion","titulo":"Próxima Medición", "descripcion":"Ve a Tu Presion y captura tu presion"]
                            self.login.saveData(collectionName: "notificaciones", id: id, info: info){
                                (done)in
                                if done{
                                    print("Succesfully upload reminder of type medition")
                                }else{
                                    print("ERROR saving info")
                                }
                            }
                        }
                        
                    }
                    
                    var nextRepDate = Calendar.current.date(byAdding: DateComponents(day: -7), to:self.date)!
                    if nextRepDate < Date(){
                        
                        nextRepDate = Date()
                    }
                    let id1 = UUID().uuidString
                    
                    let info1 : [String: Any] = ["id": id1, "idPaciente": idUser, "fecha": nextRepDate, "tipo":"reporteSemanal","titulo":"Próximo Reporte Semanal", "descripcion":"Llena tu reporte semanal"]
                    self.login.saveData(collectionName: "notificaciones", id: id1, info: info1){
                        (done)in
                        if done{
                            print("Succesfully upload reminder of type medition")
                        }else{
                            print("ERROR saving info")
                        }
                    }
                    let id2 = UUID().uuidString
                    
                    
                    let info2 : [String: Any] = ["id": id2, "idPaciente": idUser, "fecha":nextRepDate, "tipo":"reporteSalud","titulo":"Próximo Reporte Salud", "descripcion":"Llena tu reporte de salud"]
                    self.login.saveData(collectionName: "notificaciones", id: id2, info: info2){
                        (done)in
                        if done{
                            print("Succesfully upload reminder of type medition")
                        }else{
                            print("ERROR saving info")
                        }
                    }
                    
                    
                    
                    let id3 = UUID().uuidString
                    
                    let info3 : [String: Any] = ["id": id3, "idPaciente": idUser, "fecha":self.date, "tipo":"consulta","titulo":"Próxima Consulta", "descripcion":self.comments]
                    self.login.saveData(collectionName: "notificaciones", id: id3, info: info3){
                        (done)in
                        if done{
                            print("Succesfully upload reminder of type medition")
                        }else{
                            print("ERROR saving info")
                        }
                    }
                    
                    if remindsUpdated {
                        alertTitle = "¡Éxito!"
                        alertMessage = "Los datos se han guardado correctamente"
                        appointUploaded = true

                    }else {
                        alertTitle = "¡Oops!"
                        alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                        appointUploaded = false
                    }

                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    appointUploaded = false

                }
            }
                
        }
        return (appointUploaded, alertTitle, alertMessage)
    }

    func updateAppointment(date: Date, idMedic : String, comments : String)-> (Bool, String, String){
        let validationResults = self.validateAppointment()
            
        var appIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var appUploaded = false

        if appIsValid {
            
            let info : [String: Any] = ["fecha": date, "idMedico": idMedic,  "comentario": comments]
  
            login.updateData(collectionName: "consultas", id: self.id, info: info){(done)
                in
                if done{
                    alertTitle = "¡Éxito!"
                    alertMessage = "Los datos se han guardado correctamente"
                    appUploaded = true
                }else{
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                }
            }
                
        }
        return (appUploaded, alertTitle, alertMessage)
    }

}
