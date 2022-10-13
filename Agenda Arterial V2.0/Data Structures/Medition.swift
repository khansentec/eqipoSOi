//
//  Medition.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation
import Firebase

class Medition{
    var save = FirebaseViewController()
    var date : Date
    var captures = [Capture]()
    var avgSup : Int?
    var avgInf : Int?
    var avgPulse : Int?
    var state : String?
    var color : String?
    
    init(date: Date?, captures: [Capture]?){
        self.date = date ?? Date()
        self.captures = captures ?? []
    }
    
    func calculateAvg(captures: [Capture]) {
        var numPulse = 0
        var avgSup = 0
        var avgInf = 0
        var avgPulse = 0
        
        for capture in captures {
            print("Capture: \(capture.presion)")
            avgSup += Int(capture.presion.0)!
            print("Avgsup: \(avgSup)")
            
            avgInf += Int(capture.presion.1)!
            print("Infsup: \(avgInf)")
            
            if capture.pulse != 0 {
                avgPulse += capture.pulse
                numPulse += 1
            }
            print("AvgPuls: \(avgPulse)")
        }
        
        self.avgSup = avgSup / captures.count
        self.avgInf = avgInf / captures.count
        
        if numPulse > 0{
            avgPulse = avgPulse / numPulse
        }
        self.avgPulse = avgPulse
        
    }
    
    func determineState(){
        if avgSup! > 140 && avgInf! > 90 {
            self.state = "mal"
        }else if avgSup! >= 130 &&  avgInf! >= 85 {
            self.state = "regular"
        }else if avgSup! < 130 &&  avgInf! < 85 {
            self.state = "bien"
        }else{
            self.state = "Sin determinar"
        }
    }
    
    func updatePatientStatus()-> (Bool, String, String){
        var statusPatient = "Sin determinar"
        if self.state == "mal"{
            statusPatient = "alerta"
        }else if self.state == "regular"{
            statusPatient = "preocupacion"
        }else if self.state == "bien"{
            statusPatient = "correcto"
        }
        
        var alertTitle = "¡Oops!"
        var alertMessage = "Los datos se han guardado correctamente"
        var statusUpdated = true
        
        
        self.save.saveStatus(statusPatient: statusPatient){(done)
            in
            if done{
                alertTitle = "¡Éxito!"
                alertMessage = "Los datos se han guardado correctamente"
            }else{
                alertMessage = "Los datos no se han podido guardar. Intente más tarde"
            }
        }
        
        return (statusUpdated, alertTitle, alertMessage)
    }
    
    func validateMedition () -> (Bool, String, String){
        var capturesToUpload = [Capture]()
        for capture in captures {
            let captureV = capture.validateCapture()
            if !captureV.0{
                return (false, "¡Oops!", captureV.1)
            }else if captureV.0 && captureV.1 != "Sin datos"{
                capturesToUpload.append(capture)
            }
        }
        
        if capturesToUpload.isEmpty{
            return (false, "¡Oops!", "Debe ingresar al menos una captura válida")
        }else{
            self.calculateAvg(captures: capturesToUpload)
            self.determineState()
            
            var alertTitle = "¡Éxito!"
            var alertMessage = "Los datos se han guardado correctamente"
            var meditionUploaded = true
            
            let id = UUID().uuidString
            
            guard let idUser = Auth.auth().currentUser?.uid else{
                return (false, "Error En La Sesion", "Usuario no encontrado")
            }
            
            let info : [String: Any] = ["id": id,"idPaciente":idUser, "estado": self.state,  "fecha": date, "presionInfPromedio": avgInf, "presionSupPromedio": avgSup, "pulsoPromedio": avgPulse]
            save.deleteOldRemindByType(type: "medicion", date: date)
            
            self.save.saveData(collectionName: "mediciones", id: id, info: info){(done)
                in
                if done{
                    
                    alertTitle = "¡Éxito!"
                    alertMessage = "Los datos se han guardado correctamente"
                    meditionUploaded = true
                    
                }else{
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                }
            }
            
            if self.save.isSameDay(date1: date, date2: Date()){
                self.updatePatientStatus()
            }
            
            return (meditionUploaded, alertTitle, alertMessage)
        }
        
        
        
        
    }
    
}




