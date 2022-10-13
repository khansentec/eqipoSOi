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
    
    init(id :  String, name : String?, patName : String?, matName : String?, photo : String?, sex : String?, pacientStatus : String?, birthDate : Date, phone : String?,  height : Float?, weight : Float?, cirAbdominal : Float?, medDisease : String?, bloodType : String?, vinculationCode : String?, associatedMedic : [String]?){
        self.id = id
        self.name = name ?? ""
        self.patName = patName ?? ""
        self.matName = matName ?? ""
        self.photo = photo ?? ""
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
    
    func changeInfoPatient(newName : String, newPatName : String, newMatName : String, newPhoto : String, newSex : String, newBirthDate : Date, newPhone : String,  newHeight : Float, newWeight : Float, newCirAbdominal : Float, newMedDisease : String, newBloodType : String) -> (Bool,String) {
        if newName == "" {
            return (false, "Se debe ingresar el nombre")
        }
        
        if newPatName == "" {
            return (false, "Se debe ingresar el apellido Paterno")
        }
        
        if newMatName == "" {
            return (false, "Se debe ingresar el apellido Materno")
        }
        
        if newPhone != ""{
            let phoneFormat  = "^((\\+)|(00))[0-9]{6,14}$"
            let validatePhone = NSPredicate(format:"SELF MATCHES %@",  phoneFormat)
            let validationPhone =  validatePhone.evaluate(with: newPhone)
            if !validationPhone  {
                return (false, "Se debe un teléfono válido")
            }
        }
        
        if newHeight < 0 || newHeight > 999 {
            return (false, "La altura tiene que ser mayor a 0 y menor a 999")
        }
        
        if newWeight  < 0 || newWeight > 999{
            return (false, "El peso tiene que ser mayor a 0 y menor a 999")
        }
        
        if newCirAbdominal  < 0 ||  newCirAbdominal > 999{
            return (false, "La circunferencia abdominal tiene que ser mayor a 0 y menor a 999")
        }
        
        self.name = newName
        self.patName = newPatName
        self.matName = newMatName
        self.photo = newPhoto
        self.sex = newSex
        self.birthDate = newBirthDate
        self.phoneNumber = newPhone
        self.height = newHeight
        self.weight = newWeight
        self.cirAbdominal = newCirAbdominal
        self.medDisease = newMedDisease
        self.bloodType = newBloodType
        return (true, "")
    }
    
}



