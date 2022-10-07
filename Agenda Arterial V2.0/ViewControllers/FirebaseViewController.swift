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
                let info : [String: Any] = ["idUsuario":idUser,"apellidoMaterno":mtName, "apellidoPaterno": ptName, "email":email, "fechaNacimiento": bDate, "nombre":name, "sexo":sex, "telefono": phone, "altura":0, "circunferenciaAbdominal":0, "foto": "", "peso": 0, "tipoSangre": "", "padecimientosMedicos": "", "codigoVinculacion":"","estadoPacient":"", "fechaProximaConsulta":Date(),"fechUltimaConsulta":Date(), "medicoProximaConsulta":"", "MedicoUltimaConsulta":"", "listaMedicosVinculados":[]]
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
    
    //Save
    //
    func saveBP(state: String, dateC: Date, pressureS: Int, pressureD: Int, pulse: Int, completion: @escaping(_ done: Bool)->Void){
        
        //        let storage = Storage.storage().reference()
        //Save Text
        let db = Firestore.firestore()
        let id = UUID().uuidString
        
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        
        let info : [String: Any] = ["idUsuario":idUser, "estado":state,  "fecha": dateC, "presionInfPromedio":pressureS, "presionSupPromedio":pressureD, "pulsoPromedio":pulse ]
        
        db.collection("mediciones").document(id).setData(info){error in
            if let error = error?.localizedDescription{
                print("Error al guardar en firestore ", error)
                completion(false)
            }else{
                print("Sucessfully save info")
                completion(true)
            }
        }
        //End Saving Text
    }
    
    func saveGD(height: Float, abdominalCir: Float, diseases: String, weight: Float, bType: String, photo: Data, completion: @escaping(_ done: Bool)->Void){
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
                                                          let info : [String: Any] = ["altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                                          
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
                                                          let info : [String: Any] = ["altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                                          
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
    
    func getPacient(email : String){
        print(email)
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

