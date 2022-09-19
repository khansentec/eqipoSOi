//
//  FirebaseViewController.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 17/09/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewController: ObservableObject{
    
    @Published var show = "Login"
    @Published var autfail = false
    @Published var data = [FirebaseViewController]()
    @Published var itemUpdate : FirebaseViewController!
    @Published var showEditing = false
    
    func sendData(item: FirebaseViewController){
        itemUpdate = item
        showEditing.toggle()
    }
    
    func login( email: String, pass: String, completion: @escaping( _ done: Bool) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: pass){
            (user, error) in
            if user != nil{
                completion(true)
            }else{
                self.autfail = true
                if let error = error?.localizedDescription{
                    print("Error in firebase: ",error)
                    completion(false)
                }else{
                    print("Error in the app")
                }
                
            }
        }
    }
    func createUser( email: String, pass: String, completion: @escaping( _ done: Bool, _ errorM: String) -> Void)  {
        Auth.auth().createUser(withEmail: email, password: pass){
            (user, error) in
            if user != nil{
                completion(true, "ok")
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
    /*
    func save(title: String, description: String, plataform: String, frontpage: Data, completion: @escaping(_ done: Bool)->Void){
        
        let storage = Storage.storage().reference()
        let nameFrontPage = UUID()
        let directory = storage.child("images/\(nameFrontPage)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(frontpage, metadata: metaData){data, error in
            if error == nil{
                print("saved image")
            //Save Text
                let db = Firestore.firestore()
                let id = UUID().uuidString

                guard let idUser = Auth.auth().currentUser?.uid else{
                   return
                }
                guard let email = Auth.auth().currentUser?.email else{
                    return
                }

                let info : [String: Any] = ["title":title, "decription":description, "frontpage":String(describing: directory), "idUser":idUser, "email": email]

                db.collection(plataform).document(id).setData(info){error in
                    if let error = error?.localizedDescription{
                        print("Error al guardar en firestore ", error)
                        completion(false)
                    }else{
                        print("Sucessfully save info")
                        completion(true)
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
    
    
    func getData(plataform: String){
        let db = Firestore.firestore()
        db.collection("nintendo").whereField("title", isEqualTo: "Test")
            .getDocuments() {
            (QuerySnapshot, error) in
            if let error = error?.localizedDescription{
                print("error to show data ", error)
            }else{
                self.data.removeAll()
                for document in QuerySnapshot!.documents{
                    let value = document.data()
                    let id = document.documentID
                    let title = value["title"] as? String ?? "no title"
                    let description = value["decription"] as? String ?? "no description"
                    let frontPage = value["frontpage"] as? String ?? "no frontpage "
                    
                    DispatchQueue.main.async {
                        let register = FirebaseModel(id: id, titulo: title, description: description, frontPage: frontPage)
                        self.data.append(register)
                    }
                    
                }
            }
        }
        
    }
    
    func delete(index: FirebaseModel, platform: String){
        //delete Firestore
        let id = index.id
        let db = Firestore.firestore()
        db.collection(platform).document(id).delete()
        //delete Storage
        let image = index.frontPage
        let deleteImage = Storage.storage().reference(forURL: image)
        deleteImage.delete(completion: nil)
        
    }
    
    func edit(title: String, description: String, plataform: String, id: String, completion: @escaping(_ done: Bool)->Void){
        let db = Firestore.firestore()
        let info : [String:Any] = ["title": title, "decription": description]
        
        db.collection(plataform).document(id).updateData(info){error in
            if let error = error?.localizedDescription{
                print("Error while editing ", error)
                completion(false)
            }else{
                print("edit only text")
                completion(true)
            }
        }
    }
    
    func editWithImage(title: String, description: String, plataform: String, id: String, index: FirebaseModel, frontPage : Data, completion: @escaping(_ done: Bool)->Void){
        let image = index.frontPage
        let deleteImage = Storage.storage().reference(forURL: image)
        deleteImage.delete(completion: nil)
        
        let storage = Storage.storage().reference()
        let nameFrontPage = UUID()
        let directory = storage.child("images/\(nameFrontPage)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(frontPage, metadata: metaData){data, error in
            if error == nil{
                print("Error editing image")
                let db = Firestore.firestore()
                let info : [String:Any] = ["title": title, "decription": description, "frontpage": String(describing: directory)]
                
                db.collection(plataform).document(id).updateData(info){error in
                    if let error = error?.localizedDescription{
                        print("Error while editing ", error)
                        completion(false)
                    }else{
                        print("edit only text")
                        completion(true)
                    }
                }
            }else{
                if let error = error?.localizedDescription{
                    print("Failes to upload image in storge", error)
                }else{
                    print("app error")
                }
            }
        }
        
        
    }*/
    
}

