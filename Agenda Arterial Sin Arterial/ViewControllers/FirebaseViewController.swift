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
    @Published var medics = [Medic]()
    @Published var records = [MeditionRecord]()
    @Published var updateRecord : MeditionRecord!
    
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
    
    func sendRecord(item: MeditionRecord){
        updateRecord = item
    }
    
    func saveData(collectionName: String, id: String, info: [String: Any], completion: @escaping(_ done: Bool)->Void){
        
        let db = Firestore.firestore()
        print("Here3 \(collectionName)")
        print("Here4 \(info)")
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
    
    func deleteAppointment(id: String, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        db.collection("consultas").document(id).delete{
            error in
            if let error = error?.localizedDescription{
                print("Error al borrar en firestore ", error)
                completion(false)
            }else{
                print("Sucessfully delete info")
                completion(true)
            }
        }
        
    }
    
    func sendPasswordReset(withEmail email: String, completion: @escaping( _ done: Bool) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email){
            (error) in
            if let error = error?.localizedDescription{
                print("Error  ", error)
                completion(false)
            }else{
                print("Send email")
                completion(true)
            }
        }
    }
    
    func login( email: String, pass: String, completion: @escaping( _ done: Bool) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: pass){
            (user, error) in
            if user != nil{
                completion(true)
            }else{
                self.autfail = true
                if var error = error?.localizedDescription{
                    
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
                let pacient = Pacient(id: idUser, name: name, patName: ptName, matName: mtName, photo: "", sex: sex, pacientStatus: "", birthDate: bDate, phone: phone, height: 0, weight: 0, cirAbdominal: 0, medDisease: "", bloodType: "", vinculationCode: "", associatedMedic: [])
                let info : [String: Any] = ["idUsuario":idUser,"apellidoMaterno":mtName, "apellidoPaterno": ptName, "email":email, "fechaNacimiento": bDate, "nombre":name, "sexo":sex, "telefono": phone, "altura":0, "circunferenciaAbdominal":0, "foto": "", "peso": 0, "tipoSangre": "", "padecimientosMedicos": "Sin padecimientos ...", "codigoVinculacion":"","estadoPaciente":"", "listaMedicosVinculados":[]]
                self.data = pacient
                let id = UUID().uuidString
                
                db.collection("pacientes").document(id).setData(info){error in
                    
                    if let errorM = error?.localizedDescription{
                        
                        print("Error al guardar en firestore \(type(of: errorM)) as ", errorM)
                        completion(false,errorM)
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
    
    func saveGD(name: String, lastNP: String, lastNM: String,  phone: String, sex: String, height: Float, abdominalCir: Float, diseases: String, weight: Float, bType: String, photo: Data, urlPhoto: String?, editingPhoto: Bool, birthDate: Date, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        var docId = ""
        print("foto before:")
        db.collection("pacientes").whereField("idUsuario", isEqualTo: idUser)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        docId = document.documentID
                        let value = document.data()
                        let fotoF = value["foto"] as? String ?? "no profile pic"
                        print("fotoF: \(fotoF)")
                        if fotoF == ""{
                            print("first")
                            let storage = Storage.storage().reference()
                            let profilepic = UUID()
                            let directory = storage.child("profilepics/\(profilepic)")
                            let metaData = StorageMetadata()
                            metaData.contentType = "image/png"
                            
                            directory.putData(photo, metadata: metaData){data, error in
                                if error == nil{
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
                                            print("url : \(dir)")
                                            let info : [String: Any] = ["apellidoMaterno":lastNP, "apellidoPaterno": lastNM, "nombre":name, "sexo":sex,"fechaNacimiento":birthDate, "telefono": phone,"altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                            
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
                            print("foto from class: \(self.data.photo)")
                            let value = document.data()
                            let image = value["foto"] as? String ?? "no profile pic"
                            let storageImage = Storage.storage().reference(forURL: self.data.photo)
                            storageImage.getData(maxSize: 1*1024*1024){
                                (data, error) in
                                if let error = error?.localizedDescription {
                                    
                                    print("foto here in third")
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
                                                    print("url : \(dir)")
                                                    let info : [String: Any] = ["apellidoMaterno":lastNM, "apellidoPaterno": lastNP, "nombre":name, "sexo":sex,"fechaNacimiento":birthDate, "telefono": phone,"altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                                    
                                                    db.collection("pacientes").document(docId).updateData(info){error in
                                                        if let error = error?.localizedDescription{
                                                            print("Error al guardar en firestore ", error)
                                                            completion(false)
                                                        }else{
                                                            print("Sucessfully save info")
                                                            self.getPacient(){
                                                                (done)in
                                                                if done{
                                                                    print("info succesfully update")
                                                                    completion(true)
                                                                }
                                                            }
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
                                else{
                                    if !editingPhoto{
                                        print("foto: second")
                                        let info : [String: Any] = ["apellidoMaterno":lastNP, "apellidoPaterno": lastNM, "nombre":name, "sexo":sex,"fechaNacimiento":birthDate, "telefono": phone,"altura":height,"circunferenciaAbdominal":abdominalCir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                        
                                        db.collection("pacientes").document(docId).updateData(info){error in
                                            if let error = error?.localizedDescription{
                                                print("Error al guardar en firestore ", error)
                                                completion(false)
                                            }else{
                                                print("Sucessfully save info")
                                                self.getPacient(){
                                                    (done)in
                                                    if done{
                                                        print("update info succesfully")
                                                        completion(true)
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }else{
                                        
                                        print("foto here in third")
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
                                                        print("url : \(dir)")
                                                        let info : [String: Any] = ["apellidoMaterno":lastNM, "apellidoPaterno": lastNP, "nombre":name, "sexo":sex, "fechaNacimiento":birthDate,"telefono": phone,"altura":height,"circunferenciaAbdominal":abdominalCir,"foto": dir, "peso":weight, "tipoSangre": bType, "padecimientosMedicos":diseases]
                                                        
                                                        db.collection("pacientes").document(docId).updateData(info){error in
                                                            if let error = error?.localizedDescription{
                                                                print("Error al guardar en firestore ", error)
                                                                completion(false)
                                                            }else{
                                                                print("Sucessfully save info")
                                                                self.getPacient(){
                                                                    (done)in
                                                                    if done{
                                                                        print("info succesfully update")
                                                                        completion(true)
                                                                    }
                                                                }
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
                }
            }
        
        
        
    }
    
    func getPacient(completion: @escaping(_ done: Bool)->Void){
        let idUser = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("pacientes").whereField("idUsuario", isEqualTo: idUser!)
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
                        let birthDate = (value["fechaNacimiento"] as? Timestamp)?.dateValue()  ?? Date()
                        let height = value["altura"] as? Float ?? 0
                        let weight  = value["peso"] as? Float ?? 0
                        let cirAbdominal = value["circunferenciaAbdominal"] as? Float ?? 0
                        let diseases = value["padecimientosMedicos"] as? String ?? "no ailings"
                        let bloodType = value["tipoSangre"] as? String ?? "no blood type"
                        let vinculationCode = value["codigoVinculacion"] as? String ?? "no code"
                        let associatedMedic = value["listaMedicosVinculados"] as? [String] ?? []
                        DispatchQueue.main.async {
                            let register = Pacient(id: id, name: name, patName: patName, matName: matName, photo: foto, sex: sex, pacientStatus: pacientStatus, birthDate: birthDate, phone: phone, height: height, weight: weight, cirAbdominal: cirAbdominal, medDisease: diseases, bloodType: bloodType, vinculationCode: vinculationCode, associatedMedic: associatedMedic)
                            self.data = register
                            completion(true)
                        }
                        
                    }
                }
            }
        
    }
    
    func generateLinkCode(completion: @escaping(_ done: Bool)->Void) -> [Int]{
        
        var linkCode = [Int]()
        var linkCodeS = ""
        for _ in 1...4{
            let randomInt = Int.random(in: 0..<9)
            linkCodeS.append(String(randomInt))
            linkCode.append(randomInt)
        }
        let db = Firestore.firestore()
        guard let email = Auth.auth().currentUser?.email else{
            return [0,0,0,0]
        }
        db.collection("pacientes").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let linkCodeF: [String: Any] = ["codigoVinculacion":linkCodeS]
                        db.collection("pacientes").document(document.documentID).updateData(linkCodeF){error in
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
            }
        
        return linkCode
    }
    
    func deleteLinkCode(completion: @escaping(_ done: Bool)->Void){
        
        
        var linkCodeS = ""
        
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        db.collection("pacientes").whereField("idUsuario", isEqualTo: idUser)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let linkCodeF: [String: Any] = ["codigoVinculacion":linkCodeS]
                        db.collection("pacientes").document(document.documentID).updateData(linkCodeF){error in
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
            }
        
    }
    
    func getMedics(){
        
        let db = Firestore.firestore()
        let idUser = Auth.auth().currentUser?.uid
        
        db.collection("pacientes").whereField("idUsuario", isEqualTo: idUser!)
            .getDocuments() {
                
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    for document in QuerySnapshot!.documents{
                        
                        let value = document.data()
                        let associatedMedic = value["listaMedicosVinculados"] as? [String] ?? []
                        
                        for medic in associatedMedic{
                            db.collection("medicos").whereField("uid", isEqualTo: medic)
                                .getDocuments() {
                                    (QuerySnapshot, error) in
                                    if let error = error?.localizedDescription{
                                        print("error to show data ", error)
                                    }else{
                                        self.medics.removeAll()
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
                                                let register =  Medic(id: id, name: name, patName: patName, matName: matName, email: email, foto: foto, proflicense: proflicense)
                                                self.medics.append(register)
                                            }
                                            
                                        }
                                    }
                                }
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
        db.collection("medicamentos").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    self.meds.removeAll()
                    for document in QuerySnapshot!.documents{
                        
                        let value = document.data()
                        let active = value["activo"] as? Bool ?? true
                        
                        if active {
                            let id = document.documentID
                            let medName = value["nombreMedicamento"] as? String ?? "no name"
                            let info = value["informacion"] as? String ?? "no id"
                            let startDate = (value["fechaInicio"] as? Timestamp)?.dateValue() ?? Date()
                            let endDate = (value["fechaDesactivacion"] as? Timestamp)?.dateValue() ?? Date()
                            let forgetTimes = value["vecesOlvidado"] as? Int ?? 0
                            DispatchQueue.main.async {
                                let register = Medicament(id: id, idPacient: idUser, medicamentName: medName, information: info, startDate: startDate, finishDate: endDate, forgetTimes: forgetTimes)
                                self.meds.append(register)
                            }
                            
                        }
                        
                        
                    }
                }
            }
        
    }
    
    func editMedicament(id: String, finishDate: Date, startDate: Date, information: String,  completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        db.collection("medicamentos").whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    let info: [String: Any] = ["fechaDesactivacion":finishDate,"fechaInicio":startDate,"idPaciente":idUser,"informacion":information]
                    
                    db.collection("medicamentos").document(id).updateData(info){error in
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
    }
    
    
    
    func disableMedicament(idMedicament: String,endDate: Date, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        db.collection("medicamentos").whereField("id", isEqualTo: idMedicament)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    let info: [String: Any] = ["activo":false,"fechaDesactivacion":endDate]
                    db.collection("medicamentos").document(idMedicament).updateData(info){error in
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
    }
    
    func checkPastDates(id: String,finishDate: Date, startDate: Date, information: String)->(Bool, String, String){
        
        print("dates: \(finishDate)")
        print("dates: \(startDate)")
        var submitted = false
        var tittle = ""
        var message = ""
        
        if finishDate < startDate {
            print("Here1")
            self.editMedicament(id: id, finishDate: startDate, startDate: startDate, information: information){
                (done) in
                if done{
                    print("UPDATED")
                    submitted = true
                    tittle = "¡Éxito!"
                    message = "La información se actualizado con exito"
                }else{
                    tittle = "¡Opps!"
                    message = "Ha habido un error en la conexión, intentelo mas tarde"
                }
            }
        }else if finishDate > startDate{
            print("Here2")
            self.disableMedicament(idMedicament: id, endDate: finishDate){
                (done) in
                if done{
                    submitted = true
                    tittle = "¡Éxito!"
                    message = "La información se actualizado con exito"
                }else{
                    tittle = "¡Opps!"
                    message = "Ha habido un error en la conexión, intentelo mas tarde"
                }
            }
        }else{
            print("Here3")
            self.editMedicament(id: id, finishDate: finishDate, startDate: startDate, information: information){
                (done) in
                if done{
                    submitted = true
                    tittle = "¡Éxito!"
                    message = "La información se actualizado con exito"
                }else{
                    tittle = "¡Opps!"
                    message = "Ha habido un error en la conexión, intentelo mas tarde"
                }
            }
            
        }
        return(submitted,tittle,message)
    }
    
    func updateRemiders(date: Date, type: String, title:String, description : String){
        let id = UUID().uuidString
        
        let idUser = Auth.auth().currentUser?.uid
        
        let info : [String: Any] = ["id": id, "idPaciente": idUser, "fecha": date, "tipo": type,  "titulo": title, "descripcion": description]
        
        self.saveData(collectionName: "notificaciones", id: id, info: info){(done)
            in
            if done{
                print("save sussecfully")
            }else{
                print("error")
            }
        }
    }
    
    
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
    
    func deleteOldRemindByType(type: String, date: Date){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        
        if type == "medicion"{
            
            db.collection("notificaciones").whereField("idPaciente", isEqualTo: idUser)
                .getDocuments() {
                    (QuerySnapshot, error) in
                    if let error = error?.localizedDescription{
                        print("error to show data ", error)
                    }else{
                        for document in QuerySnapshot!.documents{
                            let value = document.data()
                            let idS = value["id"] as? String ?? "no id"
                            let type = value["tipo"] as? String ?? "no type"
                            let dateS = (value["fecha"] as? Timestamp)?.dateValue() ?? Date()
                            if type == "medicion" {
                                if self.isSameDay(date1: date, date2: dateS){
                                    self.deleteData(collectionName: "notificaciones", id: idS){(done)
                                        in
                                        if done{
                                            print("Sucessfully delete one reminder")
                                        }else{
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            
        }else{
            db.collection("notificaciones").whereField("idPaciente", isEqualTo: idUser)
                .getDocuments() {
                    (QuerySnapshot, error) in
                    if let error = error?.localizedDescription{
                        print("error to show data ", error)
                    }else{
                        for document in QuerySnapshot!.documents{
                            let value = document.data()
                            let typeNew = value["tipo"] as? String ?? ""
                            let dateNew = (value["fechaDesactivacion"] as? Timestamp)?.dateValue() ?? Date()
                            
                            if type == typeNew &&  (dateNew < date || self.isSameDay(date1: date, date2: dateNew))  {
                                DispatchQueue.main.async {
                                    self.deleteData(collectionName: "notificaciones", id: document.documentID){(done)
                                        in
                                        if done{
                                            print("Sucessfully delete info")
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
        }
    }
    
    func getReminds(){
        var color = ""
        
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        
        let notificationHealhtreport = UserDefaults.standard.object(forKey: "showHealtReport") as? Bool ?? true
        let notificationAppoinments = UserDefaults.standard.object(forKey: "showAppoinment") as? Bool ?? true
        let notificationWeekReport = UserDefaults.standard.object(forKey: "showWeekReport") as? Bool ?? true
        let notificationMeditions = UserDefaults.standard.object(forKey: "showMeditions") as? Bool ?? true
        
        db.collection("notificaciones").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    print("Here67")
                    self.reminds.removeAll()
                    print(self.reminds)
                    for document in QuerySnapshot!.documents{
                        print("testing iddoc: \(document.documentID)")
                        let value = document.data()
                        let id = value["id"] as? String ?? "no id"
                        let type = value["tipo"] as? String ?? "no type"
                        let date = (value["fecha"] as? Timestamp)?.dateValue() ?? Date()
                        if ((id != "no id") && (type == "medicion" && notificationMeditions) || (type == "reporteSalud" && notificationHealhtreport) || (type == "reporteSemanal" && notificationWeekReport)||(type == "consulta" && notificationAppoinments)){
                            print("entro")
                            let title = value["titulo"] as? String ?? "title"
                            let description = value["descripcion"] as? String ?? "no description"
                            
                            let consulta = value["idConsulta"] as? String ?? "no hay"
                            
                            
                            DispatchQueue.main.async {
                                print(self.reminds)
                                let register =  Remind(id:document.documentID, date : date, type : type, title : title, description : description, idconsulta: consulta)
                                print(register)
                                self.reminds.append(register)
                                
                            }
                        }
                        
                    }
                }
            }
        
    }
    
    func getRecords(startDate: Date, endDate: Date){
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        
        db.collection("mediciones").whereField("idPaciente", isEqualTo: idUser)
            .getDocuments() {
                (QuerySnapshot, error) in
                if let error = error?.localizedDescription{
                    print("error to show data ", error)
                }else{
                    self.records.removeAll()
                    for document in QuerySnapshot!.documents{
                        let value = document.data()
                        let state = value["estado"] as? String ?? "Sin determinar"
                        let pressureSup = value["presionSupPromedio"] as? Int ?? 0
                        let pressureInf = value["presionInfPromedio"] as? Int ?? 0
                        let pulse = value["pulsoPromedio"] as? Int ?? 0
                        let date = (value["fecha"] as? Timestamp)?.dateValue() ?? Date()
                        if date < endDate && date > startDate{
                            
                            DispatchQueue.main.async {
                                let register = MeditionRecord(id: document.documentID, date: date, state: state, pressureInf: pressureInf, pressureSup: pressureSup, pulse: pulse)
                                self.records.append(register)
                                self.records = self.records.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
                                
                            }
                        }
                    }
                }
            }
        
    }
    
    //    func getReminds(){
    //        reminds.removeAll()
    //
    //    }
}

