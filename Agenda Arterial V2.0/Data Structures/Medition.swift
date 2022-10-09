//
//  Medition.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Medition : Identifiable {
    var id : String
    var date : Date
    var captures = [Capture]()
    var avgSup : Int
    var avgInf : Int
    var avgPulse : Int
    var state : String
    var color : String
    
    init(id: String?, date: Date?, avgSup : Int?, avgInf : Int?, avgPulse : Int?, state : String?, color: String?){
        self.id = id ?? ""
        self.date = date ?? Date()
        self.avgSup = avgSup ?? 0
        self.avgInf = avgInf ?? 0
        self.avgPulse = avgPulse ?? 0
        self.state = state ?? "Sin determinar"
        self.color = color ?? "Color.clear"
    }

    func calculateAvg() {
        var numPulse = 0
        var avgSup = 0
        var avgInf = 0
        var avgPulse = 0
        var numPulse = 0

        for capture in self.captures{
            avgSup += capture.presion.0
            avgInf += capture.presion.1
            if capture.pulse != 0 {
                avgPulse += capture.pulse
                numPulse += 1
            }
            
        }
        self.avgSup = avgSup / captures.count
        self.avgInf = avgInf / captures.count

        if numPulse > 0{
            avgPulse = avgPulse / numPulse
        }
        self.avgPulse = avgPulse
        
    }

    func determineState(){
        if avgSup > 140 && avgInf > 90 {
            self.state = "mal"
        }else if avgSup >= 130 &&  avgInf >= 85 {
            self.state = "regular"
        }else if avgSup < 130 &&  avgInf < 85 {
            self.state = "bien"
        }

    }

    func validateCapture(presionSupStr : String? , presionInfStr : String?, pulse: Int) -> (Bool, String){
        if presionSupStr != "" || presionInfStr != "" {
            if let presionSup = Int(presionSupStr!),let presionInf = Int(presionInfStr!){
                // presion valida sin pulso
                print(presionInf)
                print(presionSup)
                if (presionSup >= 0) && (presionSup <= 999) && (presionInf >= 0) && (presionInf <= 999){
                    
                    if (pulse >= 0) && (pulse <= 999){
                        // presion valida con pulso
                        print(pulse)
                        return (true, "Captura valida con pulso")
                    }else{
                        // pulso fuera de rango
                        return (false, "El pulso tiene que ser entre 0 y 999 ")
                    }
                }else{
                    return (false, "Las presiones tienen que ser entre 1 y 999")
                }
                    
                
                
            }else {
                // captura invalida
                return (false, "Se deben ingresar ambos datos de la presion y deben ser numericos")
            }
            
        }else {
            return (true, "Sin datos")
        }
    }

    func validateMedition (presionSupStr1 : String, presionInfStr1 : String, pulse1 : Int,
                       presionSupStr2 : String, presionInfStr2 : String, pulse2 : Int,
                       presionSupStr3 : String, presionInfStr3 : String, pulse3 : Int) -> (Bool, String){
        
        var currValidation : (Bool, String)
        var currValidationStatus = true
        var currAlertMessage : String = ""
        var message : String = ""

        let presionsSup = [presionSupStr1, presionSupStr2, presionSupStr3]
        let presionsInf = [presionInfStr1, presionInfStr2, presionInfStr3]
        let pulses = [pulse1, pulse2, pulse3]
        var idx = 0

        // Check all validations while valid 
        while currValidationStatus && idx < 3 {
            // Validate capture
            currValidation = self.validateCapture(presionSupStr: presionsSup[idx], presionInfStr: presionsInf[idx], pulse: pulses[idx])
            currValidationStatus = currValidation.0
            message = currValidation.1
            if currValidationStatus {
              if message != "Sin datos" {
                currAlertMessage = message
                let presionSup = Int(presionsSup[idx])!
                let presionInf = Int(presionsInf[idx])!
                let pulse = pulses[idx]
                let cap = Capture(presionSup: presionSup , presionInf: presionInf, pulse: pulse)
                self.captures.append(cap)
              }
            }else{
              currAlertMessage = message
            }
            
            idx += 1
            
        }

        //Check that at least one capture is valid
        if currValidationStatus && self.captures.count < 1 {
            currValidationStatus = false
            currAlertMessage = "Debe ingresar al menos una captura válida"
        }


        // Return validation status, alert message
        return (currValidationStatus, currAlertMessage)
    } 

    
    func prepareToUpload(date: Date){
        self.calculateAvg()
        self.determineState()
        self.meditionDate = date
    }
    
    func uploadData(date: Date, presionSupStr1: String, presionInfStr1: String, pulso1: Int,
                    presionSupStr2: String, presionInfStr2: String, pulso2: Int,
                    presionSupStr3: String, presionInfStr3: String, pulso3: Int) {
        
        var meditionUploaded = false
        // Tuple containing validation status, alert message, and new medition object
        let validationResults = self.validateMedition(presionSupStr1: presionSupStr1, presionInfStr1: presionInfStr1, pulso1: pulso1,
                                                    presionSupStr2: presionSupStr2, presionInfStr2: presionInfStr2, pulso2: pulso2,
                                                    presionSupStr3: presionSupStr3, presionInfStr3: presionInfStr3, pulso3: pulso3)
        let meditionIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1

        if meditionIsValid {
            self.prepareToUpload(date: Date)
            //método para subir a firebase regresa booleano

            let id = UUID().uuidString

            guard let idUser = Auth.auth().currentUser?.uid else{
                return (false, alertTitle, "Usuario no encontrado")
            }

            let info : [String: Any] = ["id": id,"idPaciente":idUser, "estado":self.state,  "fecha": self.meditionDate, "presionInfPromedio":self.avgInf, "presionSupPromedio":self.avgSup, "pulsoPromedio":self.avgPulse ]
        
            loginShow.saveData(collectionName: "mediciones", id: id, info: info){(done)
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

        }

        return (meditionUploaded, alertTitle, alertMessage)
            
    }

}


