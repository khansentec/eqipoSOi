//
//  Medition.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Medition : Identifiable{
    var idMedition : String
    var meditionDate : Date
    var captures = [Capture]()
    var avgSup : Int
    var avgInf : Int
    var avgPulse : Int
    
    init(fecha : Date){
        self.idMedition = ""
        self.meditionDate = fecha
        self.avgSup = 0
        self.avgInf = 0
        self.avgPulse = 0
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
                        return (false, "El pulso tiene que ser entre 1 y 999 ")
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
    
    func addCapture(newCapture : Capture){
        captures.append(newCapture)
    }
    
 
    
    func changeDate(newDate : Date){
        self.meditionDate = newDate
    }
    
    
    func calculateAvg() {
        var numPulse = 0
        for capture in self.captures{
            avgSup += capture.presion.0
            avgInf += capture.presion.1
            if capture.pulse != 0 {
                avgPulse += capture.pulse
                numPulse += 1
            }
            
        }
        avgSup = avgSup / captures.count
        avgInf = avgInf / captures.count
        if numPulse > 0{
            avgPulse = avgPulse / numPulse
        }
        
    }
}
