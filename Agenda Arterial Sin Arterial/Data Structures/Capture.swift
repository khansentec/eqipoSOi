//
//  Capture.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Capture {
    var presion : (String, String)
    var pulse : Int
    
    init(presionSup : String, presionInf : String, pulse : Int){
        self.presion = (presionSup, presionInf)
        self.pulse = pulse
    }
    
    var description : String {
        return "\(self.presion) \(self.pulse)"
    }
    func validateCapture() -> (Bool, String){
        if presion.0 != "" || presion.1 != "" {
            if let presionSup = Int(presion.0),let presionInf = Int(presion.1){
                // presion valida sin pulso
                if (presionSup >= 0) && (presionSup <= 999) && (presionInf >= 0) && (presionInf <= 999){
                    
                    if (pulse >= 0) && (pulse <= 999){
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
}
