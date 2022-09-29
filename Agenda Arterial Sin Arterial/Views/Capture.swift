//
//  Capture.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Capture : Identifiable{
    var idCaptura : String
    var presion : (Int, Int)
    var pulso : Int
    
    init(presionSup : Int, presionInf : Int, pulso : Int){
        self.idCaptura = ""
        self.presion = (presionSup, presionInf)
        self.pulso = pulso
    }
    
    var description : String {
        return "\(self.presion) \(self.pulso)"
    }
    
    
}

func validateMedition (med : Medition,
                       presionSupStr1 : String, presionInfStr1 : String, pulso1 : Int,
                       presionSupStr2 : String, presionInfStr2 : String, pulso2 : Int,
                       presionSupStr3 : String, presionInfStr3 : String, pulso3 : Int) -> (Bool, String, [Capture]){
                  
    var newCaptures : [Capture] = []
    
    var currValidation : (Bool, String)
    var currValidationStatus = true
    var currAlertMessage : String = ""

    // Validate first capture
    currValidation = med.validarCaptura(presionSupStr: presionSupStr1, presionInfStr: presionInfStr1, pulso: pulso1)
    currValidationStatus = currValidation.0
    currAlertMessage = currValidation.1
    
    // If valid, add first capture to medition and validate second capture
    if currValidationStatus {
        
        let presionSup1 = Int(presionSupStr1)!
        let presionInf1 = Int(presionInfStr1)!
        let cap1 = Capture(presionSup: presionSup1, presionInf: presionInf1, pulso: pulso1)
        newCaptures.append(cap1)
        
        currValidation = med.validarCaptura(presionSupStr: presionSupStr2, presionInfStr: presionInfStr2, pulso: pulso2)
        currValidationStatus = currValidation.0
        currAlertMessage = currValidation.1
    }
    
    // If still valid, add second catpure to medition and validate third capture
    if currValidationStatus {
        
        let presionSup2 = Int(presionSupStr2)!
        let presionInf2 = Int(presionInfStr2)!
        let cap2 = Capture(presionSup: presionSup2, presionInf: presionInf2, pulso: pulso2)
        newCaptures.append(cap2)

        currValidation = med.validarCaptura(presionSupStr: presionSupStr3, presionInfStr: presionInfStr3, pulso: pulso3)
        currValidationStatus = currValidation.0
        currAlertMessage = currValidation.1
    }
    
    // If still valid, add third capture to medition
    if currValidationStatus {
        let presionSup3 = Int(presionSupStr3)!
        let presionInf3 = Int(presionInfStr3)!
        let cap3 = Capture(presionSup: presionSup3, presionInf: presionInf3, pulso: pulso3)
        newCaptures.append(cap3)
    }
    // Return validation status, alert message, and new medition object
    return (currValidationStatus, currAlertMessage, newCaptures)
}
