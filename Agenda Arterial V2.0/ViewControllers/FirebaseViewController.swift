//
//  FirebaseViewController.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewController: ObservableObject{
    
    @Published var show = "Login"
    @Published var showApp = "Home"
    @Published var autfail = false
    @Published var data : Pacient!
    @Published var meds = [Medicament]()
    @Published var medUpdate : Medicament!
    @Published var reminds = [Remind]()
    @Published var remindUpdate : Remind!
    @Published var meditions = [Medition]()
    @Published var medicsInfo = [Medic]()

    //config notificaciones
    var meditionsRem = true
    var healthReportsRem = true
    var weekReportsRem = true
    var appointmentsRem = true
    
    
    func sendMed(item: Medicament){
        medUpdate = item
    }
    
    func sendRemind(item: Remind){
        remindUpdate = item
    }


    func login( email: String, pass: String, completion: @escaping( _ done: Bool) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: pass){
            (user, error) in
            if user != nil{
                completion(true)
            }else{
                self.autfail = true
                if var error = error?.localizedDescription{
                    
                    if error == "The password must be 6 characters long or more." {
                        error = "La contraseña tiene que tener 6 caracteres o más"
                    }else if error == "An email address must be provided." {
                        error = "Se tiene que ingresar un correo válido"
                    }
                    print("Error in firebase: ",error)
                    completion(false)
                }else{
                    print("Error in the app")
                }
                
            }
        }
    }
    
    func createUser( email: String, pass: String, name: String, ptName : String, mtName : String, bDate: Date, phone: String, sex: String, completion: @escaping( _ done: Bool, _ errorM: String) -> Void)  {
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: pass){
            (user, error) in
            if user != nil{
                guard let idUser = Auth.auth().currentUser?.uid else{
                    return
                }
                let info : [String: Any] = ["idPaciente":idUser,"apellidoMaterno":mtName, "apellidoPaterno": ptName, "email":email, "fechaNacimiento": bDate, "nombre":name, "sexo":sex, "telefono": phone, "altura":0, "circunferenciaAbdominal":0, "foto": "", "peso": 0, "tipoSangre": "", "padecimientosMedicos": "", "codigoVinculacion":"","estadoPacient":"", "fechaProximaConsulta":Date(),"fechUltimaConsulta":Date(), "medicoProximaConsulta":"", "MedicoUltimaConsulta":"", "listaMedicosVinculados":[]]
                let id = UUID().uuidString
                
                db.collection("pacientes").document(id).setData(info){error in
                    if let error = error?.localizedDescription{
                        print("Error al guardar en firestore ", error)
                        completion(false,error)
                    }else{
                        print("Sucessfully save info")
                        
                        completion(true, "ok")
                    }
                }
            }else{
                self.autfail = true
                if let error = error?.localizedDescription{
                    print("Error on register in firebase: ",error)
                    completion(false, error)
                }else{
                    print("Error in the app")
                }
                
            }
        }
    }
    
    //Database
    
    //Save Methods
    func saveGD(name: String, ptName: String, mtName: String, phone: String, date: Date, sex: String, height: Float, abdominalCir: Float, diseases: String, weight: Float, bType: String, photo: Data, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        guard let email = Auth.auth().currentUser?.email else{
            return
        }
        var docId = ""
        db.collection("pacientes").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        docId = document.documentID
                        let value = document.data()
                        let fotoF = value["foto"] as? String ?? "no profile pic"
                        
                        
                        if fotoF == ""{
                            
                            let storage = Storage.storage().reference()
                            let profilepic = UUID()
                            let directory = storage.child("profilepics/\(profilepic)")
                            let metaData = StorageMetadata()
                            metaData.contentType = "image/png"
                            
                            directory.putData(photo, metadata: metaData){data, error in
                                if error == nil{
                                    print("saved image")
                                    //Save Text
                                    var dir = "a"
                                    let db = Firestore.firestore()
                                    directory.downloadURL{
                                        url, error in
                                                      if let error = error {
                                                        // Handle any errors
                                                        print(error)
                                                      } else {
                                                        // Get the download URL for each item storage location
                                                          dir = String(describing: url!)
                                                          let info : [String: Any] = ["fechaNacimiento": bDate, "nombre":name, "sexo":sex, "telefono": phone,"apellidoMaterno":mtName, "apellidoPaterno": ptName,"altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                                          
                                                          db.collection("pacientes").document(docId).updateData(info){error in
                                                              if let error = error?.localizedDescription{
                                                                  print("Error al guardar en firestore ", error)
                                                                  completion(false)
                                                              }else{
                                                                  print("Sucessfully save info")
                                                                  completion(true)
                                                              }
                                                          }
                                                      }
                                    }
                                   
                                    
                                    //End Saving Text
                                }else{
                                    if let error = error?.localizedDescription{
                                        print("Failes to upload image in storge", error)
                                    }else{
                                        print("app error")
                                    }
                                }
                            }
                        }else{
                            let value = document.data()
                            let image = value["foto"] as? String ?? "no profile pic"
                            let deleteImage = Storage.storage().reference(forURL: image)
                            deleteImage.delete(completion: nil)
                            
                            let storage = Storage.storage().reference()
                            let profilepic = UUID()
                            let directory = storage.child("profilepics/\(profilepic)")
                            let metaData = StorageMetadata()
                            metaData.contentType = "image/png"
                            
                            directory.putData(photo, metadata: metaData){data, error in
                                if error == nil{
                                    print("saved image")
                                    //Save Text
                                    var dir = "a"
                                    let db = Firestore.firestore()
                                    directory.downloadURL{
                                        url, error in
                                                      if let error = error {
                                                        // Handle any errors
                                                        print(error)
                                                      } else {
                                                        // Get the download URL for each item storage location
                                                          dir = String(describing: url!)
                                                          let info : [String: Any] = ["altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":sintoms]
                                                          
                                                          db.collection("pacientes").document(docId).updateData(info){error in
                                                              if let error = error?.localizedDescription{
                                                                  print("Error al guardar en firestore ", error)
                                                                  completion(false)
                                                              }else{
                                                                  print("Sucessfully save info")
                                                                  completion(true)
                                                              }
                                                          }
                                                      }
                                    }
                                   
                                    
                                    //End Saving Text
                                }else{
                                    if let error = error?.localizedDescription{
                                        print("Failes to upload image in storge", error)
                                    }else{
                                        print("app error")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        
        
        
    }

    func saveData(collectionName: String, id: String, info: [String: Any], completion: @escaping(_ done: Bool)->Void){
        
        let db = Firestore.firestore()
        
        db.collection(collectionName).document(id).setData(info){error in
            if let error = error?.localizedDescription{
                print("Error al guardar en firestore ", error)
                completion(false)
            }else{
                print("Sucessfully save info")
                completion(true)
            }
        }
    }

    //Update

    func updateData(collectionName: String, id: String, info: [String: Any], completion: @escaping(_ done: Bool)->Void){
        
        let db = Firestore.firestore()
        db.collection(collectionName).document(id).updateData(info)
        {error in
            if let error = error?.localizedDescription{
                print("Error al actualizar en firestore ", error)
                completion(false)
            }else{
                print("Sucessfully update info")
                completion(true)
            }
        }
    }
    
    //Get 
    func getPacient(email : String){
        let db = Firestore.firestore()
        db.collection("pacientes").whereField("email", isEqualTo: email)
            .getDocuments() {
                
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        
                        let value = document.data()
                        let id = value["uid"] as? String ?? "no user"
                        let name = value["nombre"] as? String ?? "no name"
                        let patName = value["apellidoPaterno"] as? String ?? "no lastname"
                        let matName = value["apellidoMaterno"] as? String ?? "no 2° lastname"
                        let phone = value["telefono"] as? String ?? "no phone number"
                        let foto = value["foto"] as? String ?? "no profile pic"
                        let sex = value["sexo"] as? String ?? "no sex"
                        let pacientStatus = value["estadoPaciente"] as? String ?? "no state"
                        let birthDate = value["fechaNacimiento"] as? Date ?? Date()
                        let height = value["altura"] as? Float ?? 0
                        let weight  = value["peso"] as? Float ?? 0
                        let cirAbdominal = value["circunferenciaAbdominal"] as? Float ?? 0
                        let diseases = value["padecimientosMedicos"] as? String ?? "no ailings"
                        let bloodType = value["tipoSangre"] as? String ?? "no blood type"
                        let nextAppointment = value["fechaNacimiento"] as? Date ?? Date()
                        let lastAppointment = value["fechaNacimiento"] as? Date ?? Date()
                        let vinculationCode = value["codigoVinculacion"] as? String ?? "no code"
                        let associatedMedic = value["listaMedicosVinculados"] as? [String] ?? []

                        DispatchQueue.main.async {
                            let register = Pacient(id: id, name: name, patName: patName, matName: matName, photo: foto, sex: sex, pacientStatus: pacientStatus, birthDate: birthDate, phone: phone, height: height, weight: weight, cirAbdominal: cirAbdominal, medDisease: diseases, bloodType: bloodType, nextAppointment: nextAppointment, lastAppointment: lastAppointment, vinculationCode: vinculationCode, associatedMedic: associatedMedic)
                            print(vinculationCode)
                            self.data = register
                           
                        }
                        
                    }
                }
            }
        
    }

    func getMedicById(idMedic : String) -> Medic {
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        db.collection("medicos").whereField("uid", isEqualTo: idMedic)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        let value = document.data()
                        let id = value["uid"] as? String ?? "no id"
                        let name = value["nombres"] as? String ?? "no name"
                        let matName = value["apellidoMaterno"] as? String ?? "no matName"
                        let patName = value["apellidoPaterno"] as? String ?? "no patName"
                        let proflicense = value["cedulaProfesional"] as? String ?? "no proflicense"
                        let email = value["email"] as? String ?? "no email"
                        let foto = value["foto"] as? String ?? "no foto"
                        
                        DispatchQueue.main.async {
                            let register =  (id: id, email: email, patName: patName, matName: matName, name: name, foto: foto, proflicense: proflicense)
                            return register
                        }
                        
                    }
                }
            }
        
    }

    func getMeditionsByDate(startDate : Date){
        var color : Color

        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        let db = Firestore.firestore()
        db.collection("pacientes").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        
                        let value = document.data()
                        let date = value["fecha"] as? Date ?? Date()

                        if date > startDate{
                            let id = value["id"] as? String ?? "no id"
                            let avgSup = value["presionSupPromedio"] as? Int ?? 0
                            let avgInf = value["presionInfPromedio"] as? Int ?? 0
                            let avgPulse = value["pulsoPromedio"] as? Int ?? 0
                            let state = value["estado"] as? String ?? "no state"

                            if state == "mal" {
                                color = "Color.red"
                            }else if state == "regular" {
                                color = "Color.yellow"
                            }else if state == "bien" {
                                color = "Color.green"
                            }else{
                                color = "Color.gray"
                            }

                            DispatchQueue.main.async {
                                let register = Medition(id: id, date: date, avgSup : avgSup, avgInf : avgInf, avgPulse : avgPulse, state : state, color: color)
                                self.meditions.append(register)
                            }
                          
                    }
                }
            }
        
    }

    func getMedicaments(){

        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        let db = Firestore.firestore()
        db.collection("pacientes").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        
                        let value = document.data()
                        let active = value["activo"] as ? Bool ?? true

                        if active {
                            let id = value["id"] as? String ?? UUID().uuidString
                            let medName = value["nombreMedicamento"] as? String ?? "no name"
                            let info = value["informacion"] as? String ?? "no id"
                            let startDate = value["fechaInicio"] as? Date ?? Date()
                            let endDate = value["fechaDesactivacion"] as? Date ?? Date()
                            let forgetTimes = value["vecesOlvidado"] as? Int ?? 0

                            DispatchQueue.main.async {
                                let register = Medicament(id: id, medicamentName: medName, information: info, startDate: startDate, finishDate: endDate, forgetTimes: forgetTimes)
                                self.meds.append(register)
                            }

                        }
                        
                        
                    }
                }
            }
        
    }

    func getReminds(){
        var color : String

        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        db.collection("notificaciones").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        let value = document.data()
                        let id = value["id"] as? String ?? "no id"
                        let type = value["tipo"] as? String ?? "no type"

                        if (type == "medicion" && meditionsRem) || (type == "reporteSalud" && healthReportsRem) || (type == "reporteSemanal" && weekReportsRem){
                            let title = value["titulo"] as? String ?? "title"
                            let description = value["descripcion"] as? String ?? "no description"
                            let date = value["fecha"] as? Date ?? Date()

                            if type == "medicion"{
                                color = "Color.red"
                            }else type == "reporteSalud"{
                                color = "Color.green"

                            }else type == "reporteSemanal"{
                                color = "Color.blue"

                            }

                            DispatchQueue.main.async {
                                let register =  Remind(date : date, description : description, type : type, title : title, color : color)
                                self.reminds.append(register)
                            
                            }
                        }
                        
                    }
                }
        }
        
    }

    func getAppointment(){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        db.collection("consultas").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        let value = document.data()
                        let date = value["fecha"] as? Date ?? Date()
                        let currentDate = Date()
                        if (date >= currentDate && appointments){
                            let comments = value["comentarios"] as? String ?? ""
                            let idMedic = value["idMedico"] as? String ?? ""
                            let medic = self.getMedicById(idMedic)
                            let type = "consulta"
                            let title = "Consulta con " + medic.name + " " + medic.patName
                            
                            DispatchQueue.main.async {
                                let register =  Remind(date : date, type : type, title : title, description : comments, color : "Color.yellow")
                                self.reminds.append(register)
                            
                            }

                        }

                        
                        
                    }
                }
            }
        
    }

    func getMedicsInfo() {
        for idMedic in data.associatedMedic {
            let newMedic = getMedicById(idMedic : idMedic) 
            medicsInfo.append(newMedic)
        }
    }

    

    //Delete
    func deleteOldRemindByType(type: String, date: String){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }

        db.collection("notificaciones").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        let value = document.data()
                        let typeNew = value["tipo"] as? String ?? ""
                        let dateNew = value["fecha"] as? Date ?? Date()

                        if type == typeNew &&  (dateNew < date || isSameDay(date1: date, date2: dateNew))  {
                            let description = value["descripcion"] as? String ?? ""
                            let title = value["titulo"] as? String ?? ""
                            DispatchQueue.main.async {
                                self.deleteData(collectionName: "notificaciones", id: id){(done)
                                    in
                                        if done{
                                            print("Sucessfully delete info")
                                        }else{
                                            print("Error al guardar en firestore ", error)
                                        }
                                }
                            }

                        }
                    }
                }
            }
        
    }

    func deleteData(collectionName: String, id: String, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        db.collection(collectionName).document(id).delete
        {error in
            if let error = error?.localizedDescription{
                print("Error al borrar en firestore ", error)
                completion(false)
            }else{
                print("Sucessfully delete info")
                completion(true)
            }
        }
    }

    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current

        let day1 = calendar.component(.day, from: date1)
        let month1 = calendar.component(.month, from: date1)
        let year1 = calendar.component(.year, from: date1)
        let day2 = calendar.component(.day, from: date2)
        let month2 = calendar.component(.month, from: date2)
        let year2 = calendar.component(.year, from: date2)

        if day1 == day2 && month1 == month2 && year1 == year2 {
            return true
        } else {
            return false
        }
    }




    
    /*
     func delete(index: FirebaseModel, platform: String){
     //delete Firestore
     let id = index.id
     let db = Firestore.firestore()
     db.collection(platform).document(id).delete()
     //delete Storage
     let image = -deindex.frontPage
     let deleteImage = Storage.storage().reference(forURL: image)
     deleteImage.delete(completion: nil)
     
     }
     */
    
}

