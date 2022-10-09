//
//  Week Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class WeekReport {
    var followDiet : Float
    var saltConsumption : Float
    var beveragesIntake : Bool
    var numBeverages : Int
    var physicalActivity : Float
    var numPhysicalActivity : Int
    var sleepHours : Int
    var followMedicalPresciption : Bool
    var reportDate : Date
    var nextReportDate : Date
    var medicaments : [Medicament]
    
    init(followDiet : Float, saltConsumption : Float, beveragesIntake : Bool, numBeverages : Int, physicalActivity : Float, numPhysicalActivity : Int, sleepHours : Int, followMedicalPresciption : Bool, reportDate : Date, medicaments: [Medicament] ){
        self.followDiet = followDiet
        self.saltConsumption = saltConsumption
        self.beveragesIntake = beveragesIntake
        self.numBeverages = numBeverages
        self.physicalActivity = physicalActivity
        self.numPhysicalActivity = numPhysicalActivity
        self.sleepHours = sleepHours
        self.followMedicalPresciption = followMedicalPresciption
        self.reportDate = reportDate
        self.nextReportDate = Calendar.current.date(byAdding: DateComponents(day: 7), to: Date.now)!
        self.medicaments  = medicaments
    }
    
    
    func validateMedicaments()->(Bool, String){
        var forgotAnyMedicament = false
        //cambiar de a donde se encuentren los medicamentos
        for medicament in self.medicaments {
            if medicament.forgetTimes != 0{
                forgotAnyMedicament = true
                if medicament.forgetTimes < 0 || medicament.forgetTimes > 99{
                    return (false, "El número de veces que ha olvidado el médicamento debe ser entre 0 y 99")
                }
            }
        }
        
        if self.followMedicalPresciption && forgotAnyMedicament {
            return (false, "Si se le olvidó un medicamento, tiene que indicar que NO siguió la receta")
        }else if !self.followMedicalPresciption && !forgotAnyMedicament {
            return (false, "Si no se le olvidó un medicamento, tiene que indicar que sí siguió la receta")
        }else {
            return (true, "Datos válidos")
        }
        
    }
    
    func validateWR() -> (Bool,String){
        if self.beveragesIntake {
            if self.numBeverages <= 0 || self.numBeverages > 99 {
                return (false, "La cantidad de refrescos debe ser entre 0 y 99")
            }
                
        }else {
            if self.numBeverages != 0 {
                return(false, "Favor de indicar que consumió refrescos")
            }
        }
            
            if self.numPhysicalActivity < 0 || self.numPhysicalActivity > 99{
                return (false, "La cantidad de actividad física debe ser entre 0 y 99")
            }
            
            if self.sleepHours < 0 || self.sleepHours > 24 {
                return (false, "Las horas de descanso deben ser entre 0 y 24")
            }
            
            let validationMedicaments = validateMedicaments()
            
            if !validationMedicaments.0{
                return (validationMedicaments)
            }
            
            return (true, "Datos válidos")
            
            
        }
        
    func updateMedicaments() -> Bool {
            var medicamentsUploaded = false
            for medicament in self.medicaments {
                print(medicament.forgetTimes)
                // FALTA IMPLEMENTAR QUE SE BORREN
                login.updateData(collectionName: "medicamentos" , id: medicament.id , info: ["vecesOlvidado" : medicament.forgetTimes] ){(done)
                in
                    if done{
                        return true
                    }
                    return false
                }

            }
            return medicamentsUploaded
    }
        
    func uploadWR() -> (Bool, String, String){
        let validationResults = self.validateWR()
            
        var reportIsValid = validationResults.0
        var alertTitle = "¡Oops!"
        var alertMessage = validationResults.1
        var weekRUploaded = false
            
        if reportIsValid {
            //método para subir a firebase regresa booleano
            let id = UUID().uuidString
        
            guard let idUser = Auth.auth().currentUser?.uid else{
                return (false, alertTitle, "Usuario no encontrado")
            }
            
            let info : [String: Any] = ["id": id, "idPaciente": idUser, "fecha": self.reportDate, "seguimientoDieta": self.followDiet,  "consumoSal": self.saltConsumption, "consumoRefrescos": self.beveragesIntake, "cantidadRefrescos": self.numBeverages, "actividadFisica": self.physicalActivity, "numActividadFisica": self.numPhysicalActivity, "horasDescanso": self.sleepHours, "seguimientoReceta": self.followMedicalPresciption, "fechaSigReporte": self.nextReportDate]
            
            loginShow.saveData(collectionName: "reportesSemanales", id: id, info: info){(done)
                in
                if done{

                    var newRemind = Remind(date: self.nextReportDate, type: "reporteSemanal", title: "Próximo Reporte Semanal", description: "Llena tu reporte semanal", color : "Color.blue")
                    
                    var remindsUpdated = newRemind.updateRemind()

                    var medicamentsUpdated = self.updateMedicaments()

                    if medicamentsUpdated && remindsUpdated {
                        alertTitle = "¡Éxito!"
                        alertMessage = "Los datos se han guardado correctamente"
                        weekRUploaded = true

                    }else {
                        alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                    }

                }else{
                    alertMessage = "Los datos no se han podido guardar. Intente más tarde"
                }
            }
                
        } 
        return (weekRUploaded, alertTitle, alertMessage)
    }
        
        
}

