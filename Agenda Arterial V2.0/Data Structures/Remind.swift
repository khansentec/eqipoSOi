//
//  Remind Report.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//
import Foundation

class Remind: Identifiable {
    var id : String
    var date : Date
    var type : String
    var title : String
    var description : String
    var color : String

    init(id : String?, date: Date, type : String, title : String, description : String, color : String?){
        self.id = id ?? ""
        self.date = date
        self.type = type
        self.title = title
        self.description = description
        self.color = color ?? "Color.clear"
    }

    func uploadRemind() -> (Bool, String, String){
        
        let id = UUID().uuidString
        
        guard let idUser = Auth.auth().currentUser?.uid else{
            return
        }
        
        let info : [String: Any] = ["id": id, "idPaciente": idUser, "fecha": self.date, "tipo": self.type,  "titulo": self.title, "descripcion": self.description]
        
        loginShow.saveData(collectionName: "notificaciones", id: id, info: info){(done)
                in
                    if done{
                        return (true, "¡Éxito!", "Los datos se guardaron correctamente")
                    }else{
                        return (false, "¡Oops!", "No se han podido guardar los datos, intenta más tarde")
                    }
        }
    }


    func updateRemind() -> Bool{
        // Deletes all previous reminds
        do {
            try login.deleteOldRemindByType(self.type, date: self.date = date)
            print("Success! Yum.")
        } catch {
                print("Unexpected error: \(error).")
        }
        let done = self.uploadRemind()
        if done{
            return true
        }
        return false

    }
}