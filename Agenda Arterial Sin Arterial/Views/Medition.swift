//
//  Medition.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Medition : Identifiable{
    var idMedicion : String
    var idPaciente : String
    var fecha : Date
    var capturas = [Capture]()
    
    init(idPaciente : String, fecha : Date){
        self.idMedicion = ""
        self.idPaciente = idPaciente
        self.fecha = fecha
    }
    
    func validarCaptura(presionSupStr : String? , presionInfStr : String?, pulso: Int) -> (Bool, String){
        if presionSupStr != "" || presionInfStr != "" {
            if let presionSup = Int(presionSupStr!),let presionInf = Int(presionInfStr!){
                // presion valida sin pulso
                print(presionInf)
                print(presionSup)
                if (pulso >= 1) && (pulso <= 999){
                    // presion valida con pulso
                    print(pulso)
                    return (true, "Captura valida con pulso")
                }else{
                    // pulso fuera de rango
                    return (false, "El pulso tiene que ser entre 1 y 999 ")
                }
                
            }else {
                // captura invalida
                return (false, "Se deben ingresar ambos datos de la presion y deben ser numericos")
            }
            
        }else {
            return (true, "Sin datos")
        }
    }
    
    func agregarCaptura(nuevaCaptura : Capture){
        capturas.append(nuevaCaptura)
    }
    
    func cambiarIDPaciente(nuevoIdPaciente : String){
        self.idPaciente = nuevoIdPaciente
    }
    
    func cambiarFecha(nuevaFecha : Date){
        self.fecha = nuevaFecha
    }
    
    func imprimirCapturas(){
        for captura in self.capturas{
            print(captura.description)
        }
    }
    
}
