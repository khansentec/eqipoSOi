//
//  Appointment Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation

class Appointment: Identifiable {
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
        let validationResults = self.validateWR()
            
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

            loginShow.saveData(collectionName: "consultas", id: id, info: info){(done)
                in
                if done{
                    var remindsUpdated = false
                    for n in 1…5 {
                        let nextMeditionDate = Calendar.current.date(byAdding: DateComponents(day: -n), to:self.date)!
                        let newRemind = Remind(date: nextMeditionDate, type: "medicion", title: "Próxima Medición", description: "Ve a Tu Presion y captura tu presion", color : "Color.red")
                        remindsUpdated = newRemind.uploadRemind().0
                    }

                    let nextWRDate = Calendar.current.date(byAdding: DateComponents(day: -5), to:self.date)!
                    let nextWRepRemind = Remind(date: nextWRDate, type: "reporteSemanal", title: "Próximo Reporte Semanal", description: "Llena tu reporte semanal", color : "Color.blue")
                    remindsUpdated = nextWRepRemind.uploadRemind().0

                    let newHRDate = Calendar.current.date(byAdding: DateComponents(day: -5), to:self.date)!
                    let newHRepRemind = Remind(date: newHRDate, type: "reporteSalud", title: "Próximo Reporte Salud", description: "Ve a Tu Presion y captura tu presion", color : "Llena tu reporte de salud", color : "Color.green")
                    remindsUpdated = newHRepRemind.uploadRemind().0


                    if remindsUpdated {
                        alertTitle = "¡Éxito!"
                        alertMessage = "Los datos se han guardado correctamente"
                        meditionUploaded = true

                    }else {
                        alertTitle = "¡Oops!"
                        alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                        meditionUploaded = false
                    }

                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    meditionUploaded = false

                }
            }
                
        } 
        return (meditionUploaded, alertTitle, alertMessage)
    }

    func updateAppointment(date: Date, idMedic : String, comments : String)-> (Bool, String, String){
        let validationResults = self.validateAppointment()
            
        var appIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var appUploaded = false

        if appIsValid {
            
            let info : [String: Any] = ["fecha": date, "idMedico": idMedic,  "comentario": comments]
  
            loginShow.updateData(collectionName: "consultas", id: self.id, info: info){(done)
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