//
//  Pacient.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import Foundation

class Pacient {
    var id : String
    var name : String
    var patName : String
    var matName: String
    var photo : String
    var sex : String
    var pacientStatus : String
    var birthDate : Date
    var phoneNumber : String
    var height : Float
    var weight : Float
    var cirAbdominal : Float
    var medDisease : String
    var bloodType : String
    var vinculationCode : String
    var associatedMedic : [String]
    
    init(id :  String, name : String?, patName : String?, matName : String?, photo : String, sex : String?, pacientStatus : String?, birthDate : Date, phone : String?,  height : Float?, weight : Float?, cirAbdominal : Float?, medDisease : String?, bloodType : String?, vinculationCode : String?, associatedMedic : [String]?){
        self.id = id
        self.name = name ?? ""
        self.patName = patName ?? ""
        self.matName = matName ?? ""
        self.photo = photo
        self.sex = sex ?? ""
        self.pacientStatus = pacientStatus ?? ""
        self.birthDate = birthDate
        self.phoneNumber = phone ?? ""
        self.height = height ?? 0.0
        self.weight = weight ?? 0.0
        self.cirAbdominal = cirAbdominal ?? 0.0
        self.medDisease = medDisease ?? ""
        self.bloodType = bloodType ?? ""
        self.vinculationCode = vinculationCode ?? ""
        self.associatedMedic = associatedMedic ?? []
    }
    
    func changeInfoPatient() -> (Bool,String) {
        if self.name == "" {
            return (false, "Se debe ingresar el nombre")
        }
        
        if self.patName == "" {
            return (false, "Se debe ingresar el apellido Paterno")
        }
        
        if self.matName == "" {
            return (false, "Se debe ingresar el apellido Materno")
        }
        
        if self.phoneNumber != ""{
            let phoneFormat  = "[0-9]{10}$"
            let validatePhone = NSPredicate(format:"SELF MATCHES %@",  phoneFormat)
            let validationPhone =  validatePhone.evaluate(with: self.phoneNumber)
            if !validationPhone  {
                return (false, "Se debe un teléfono válido")
            }
        }
        
        if self.height < 0 || self.height > 999 {
            return (false, "La altura tiene que ser mayor a 0 y menor a 999")
        }
        
        if self.weight  < 0 || self.weight > 999{
            return (false, "El peso tiene que ser mayor a 0 y menor a 999")
        }
        
        if self.cirAbdominal  < 0 ||  self.cirAbdominal > 999{
            return (false, "La circunferencia abdominal tiene que ser mayor a 0 y menor a 999")
        }
        
        return (true, "")
    }
    
}


