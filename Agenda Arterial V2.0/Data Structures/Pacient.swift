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
    var nextAppointment : Date
    var lastAppointment : Date
    var vinculationCode : String
    var associatedMedic : [String]

    init(id : String, name : String?, patName : String?, matName : String?, photo : String?, sex : String?, pacientStatus : String?, birthDate : Date, phone : String?,  height : Float?, weight : Float?, cirAbdominal : Float?, medDisease : String?, bloodType : String?,  nextAppointment : Date?, lastAppointment : Date?, vinculationCode : String?, associatedMedic : [String]?){
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
        self.nextAppointment = nextAppointment ?? Date()
        self.lastAppointment = lastAppointment ?? Date()
        self.vinculationCode = vinculationCode ?? ""
        self.associatedMedic = associatedMedic ?? []
    }

    func changeInfoPatient(newName : String, newPatName : String, newMatName : String, newPhoto : Data, newSex : String, newBirthDate : Date, newPhone : String,  newHeight : Float, newWeight : Float, newCirAbdominal : Float, newMedDisease : String, newBloodType : String) -> (Bool, String){
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
        self.sex = newSex
        self.birthDate = newBirthDate
        self.phoneNumber = newPhone
        self.height = newHeight
        self.weight = newWeight
        self.cirAbdominal = newCirAbdominal
        self.medDisease = newMedDisease
        self.bloodType = newBloodType
        self.nextAppointment = newNextAppointment
        return (true, "Datos válidos")
    }


    func updateGD(name: String, ptName: String, mtName: String, phone: String, date: Date, sex: String, height: Float, abdominalCir: Float, diseases: String, weight: Float, bType: String, photo: Data){
        let validationResults = self.changeInfoPatient(newName : name, newPatName : ptName, newMatName : mtName, newPhoto : photo, newSex : sex, newBirthDate : date, newPhone : phone,  newHeight : height, newWeight : weight, newCirAbdominal : abdominalCir, newMedDisease : diseases, newBloodType : bType)
        
        var infoIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1 
        var infoUploaded = false

        if infoIsValid{
            login.saveGD(name: self.name, ptName: self.patName, mtName: self.matName, phone: self.phoneNumber, date: self.birthDate, sex: self.sex, height: self.height, abdominalCir: self.cirAbdominal, diseases: self.medDisease, weight: self.weight, bType: self.bloodType, photo: photo){
                                (done, errorM) in
                if done{
                                    
                    alertTitle = "¡Éxito!"
                    alertMessage = "La cuenta se ha creado correctamente"
                    infoUploaded = true
                    
                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    infoUploaded = false
                    
                }
            }
        }
        return (infoUploaded, alertTitle, alertMessage)


    }
    


}
