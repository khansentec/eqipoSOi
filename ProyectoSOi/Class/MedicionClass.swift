//
//  Medicion.swift
//  Class
//
//  Created by alumno on 06/09/22.
//

import Foundation


class Medicion {
    var idMedicion : String
    var idPaciente : String
    var fecha : Date
    var capturas = [Captura]()
    
    init(idPaciente : String, fecha : Date){
        self.idMedicion = ""
        self.idPaciente = idPaciente
        self.fecha = fecha
    }
    
    func validarCaptura(presionSupStr : String? , presionInfStr : String?, pulsoStr: String?) -> (Bool, String){
        if presionSupStr != "" || presionInfStr != "" {
            if let presionSup = Int(presionSupStr!),let presionInf = Int(presionInfStr!){
                if pulsoStr != ""{
                    if let pulso = Int(pulsoStr!) {
                        if (pulso >= 1) && (pulso <= 999){
                            // presion valida con pulso
                            print(pulso)
                            return (true, "Captura valida con pulso")
                        }else{
                            // pulso fuera de rango
                            return (false, "El pulso tiene que ser entre 1 y 999 ")
                        }
                    }else{
                        // pulso no es numerico
                        return (false, "El pulso tiene que ser numerico")
                    }
                }
                // presion valida sin pulso
                print(presionInf)
                print(presionSup)
                return (true, "Captura valida")
            }else {
                // captura invalida
                return (false, "Se deben ingresar ambos datos de la presion y deben ser numericos")
            }
            
        }else {
            if pulsoStr != ""{
                // no se puede agregar solo pulso
                return (false, "Se deben ingresar ambos datos de la presion")
            }
            return (true, "Sin datos")
        }
    }
    
    func agregarCaptura(nuevaCaptura : Captura){
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

