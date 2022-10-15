//
//  User.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation

class User : Identifiable {
    var login = FirebaseViewController()
    var email : String
    var pass : String
    var confPass: String
    var name : String
    var ptName : String
    var mtName : String
    var bDate : Date
    var phone : String
    var sex : String
    
    init(email : String, pass : String, confPass: String, name : String, ptName : String, mtName : String, bDate : Date, phone : String, sex : String ){
        self.email = email
        self.pass = pass
        self.confPass = confPass
        self.name = name
        self.ptName = ptName
        self.mtName = mtName
        self.bDate = bDate
        self.phone = phone
        self.sex = sex
    }

    func validateUser()->(Bool, String){
        

        if self.name == "" {
            return (false, "Se debe ingresar el nombre")
        }
        
        if self.ptName == "" {
            return (false, "Se debe ingresar el apellido Paterno")
        }
        
        if self.mtName == "" {
            return (false, "Se debe ingresar el apellido Materno")
        }
        
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if !emailPredicate.evaluate(with: self.email) {
            return (false, "Favor de ingresar un formato válido de correo")
        }

        let passwordFormat  = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let validatePassword = NSPredicate(format:"SELF MATCHES %@",  passwordFormat)
        let validationPassword =  validatePassword.evaluate(with: self.pass)
        if !validationPassword  {
            return (false, "La contraseña tiene que tener una letra mayúscula, una letra minúscula, un caracter especial y un número")
        }

        if self.pass != self.confPass{
            return (false, "Las contraseñas deben coincidir")
        }
        
        if self.sex == "Selecione una opcion"{
            return (false, "Debe escoger una opción de sexo")
        }
        
        if self.phone != ""{
            let phoneFormat  = "[0-9]{10}$"
            let validatePhone = NSPredicate(format:"SELF MATCHES %@",  phoneFormat)
            let validationPhone =  validatePhone.evaluate(with: phone)
            if !validationPhone  {
                return (false, "Se debe un teléfono válido")
            }
        }
        return(true,"Datos válidos")


    }

    func uploadUser()-> (Bool, String, String){

        let validationResults = self.validateUser()
        
        let userIsValid = validationResults.0
        let alertTitle = "¡Oops!"
        let alertMessage = validationResults.1
        
        
        return (userIsValid, alertTitle, alertMessage)

    }

}
