//
//  User.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation

class User : Identifiable {
    var email : String
    var pass : String
    var confPass: String
    var name : String
    var ptName : String
    var mtName : String
    var bDate : String
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
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if !emailPredicate.evaluate(with: self.email) {
            return (false, "Favor de ingresar un formato válido de correo")
        }

        if self.name == "" {
            return (false, "Se debe ingresar el nombre")
        }
        
        if self.ptName == "" {
            return (false, "Se debe ingresar el apellido Paterno")
        }
        
        if self.mtName == "" {
            return (false, "Se debe ingresar el apellido Materno")
        }
        
        if self.phone != ""{
            let phoneFormat  = "^((\\+)|(00))[0-9]{6,14}$"
            let validatePhone = NSPredicate(format:"SELF MATCHES %@",  phoneFormat)
            let validationPhone =  validatePhone.evaluate(with: newPhone)
            if !validationPhone  {
                return (false, "Se debe un teléfono válido")
            }
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


    }

    func uploadUser()-> (Bool, String, String){

        let validationResults = self.validateUser()
        
        var userIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var userUploaded = false

        if userIsValid{
            login.createUser(email: self.email, pass: self.pass, name: self.name, ptName: self.ptName, mtName: self.mtName, bDate: self.bDate, phone: self.phone, sex: self.sex){
                                (done, errorM) in
                if done{
                    UserDefaults.standard.set(true, forKey: "sesion")
                                    
                    loginShow.show = "Home"
                    alertTitle = "¡Éxito!"
                    alertMessage = "La cuenta se ha creado correctamente"
                    userUploaded = true
                    
                }else{
                    alertTitle = "¡Oops!"
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    userUploaded = false
                    
                }
            }
        }
        
        return (userUploaded, alertTitle, alertMessage)

    }

}




                            
                            
