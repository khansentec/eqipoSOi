//
//  AddMedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

struct AddMedicamentView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameMedicament = ""
    @State var date = Date.now
    @State var frecuency = ""
    @State var dosis = ""
    @State var indications = ""
    @State var idPacient = "12345"
    
    @Binding var addMedicament : Bool
    @State var edit = false
    @State private var submited = false
    
    @State var alertTitle = ""
    @State var alertMsg = ""
    @State var medicamentSubmitted = false
    
    @StateObject var login = FirebaseViewController()
    
    var body: some View {
        VStack (spacing : 10){
            HStack{
                Text("Nombre: ")
                TextField("Nombre", text: $nameMedicament)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Text("Fecha de inicio: ").padding(.leading, 20)
                DatePicker("", selection: $date, displayedComponents : .date)
                    .padding(.trailing,70)
                
            }.padding(.all,20)
            HStack{
                Text("Frecuencia: ")
                TextField("Frecuencia en horas", text: self.$frecuency)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Text("Dosis: ")
                TextField("Dosis", text: self.$dosis)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Text("Indicaciones: ")
                TextField("Indicaciones", text: self.$indications)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Button("Guardar") {
                    let information = "Frecuencia en horas : " + frecuency + "\nDosis : " + dosis + "\nIndicaciones : " + indications
                    
                    if nameMedicament != ""{
                        
                        let id = UUID().uuidString
                        guard let idUser = Auth.auth().currentUser?.uid else{
                            return
                        }
                        let info: [String: Any] = ["nombreMedicamento":nameMedicament,"fechaDesactivacion":date,"fechaInicio":date,"idPaciente":idUser,"informacion":information,"vecesOlvidado":0,"activo":true]
                        login.saveData(collectionName: "medicamentos", id: id, info: info){
                            (done) in
                            if done{
                                alertTitle = "¡Éxito!"
                                alertMsg = "Medicamento guardado con éxito."
                                submited = true
                                medicamentSubmitted = true
                            } else{
                                alertTitle = "¡Oops!"
                                alertMsg = "Hay un problema con la red. Favor de intentar de nuevo."
                            }
                        }
                    }else{
                        alertTitle = "¡Oops!"
                        alertMsg = "Debe ingresar el nombre del medicamento."
                        medicamentSubmitted = true
                    }
                    
                }
                .alert(alertTitle, isPresented: $medicamentSubmitted){
                    Button("OK"){
                        medicamentSubmitted = false
                        //si se oprime quitar el ok
                        if submited{
                            addMedicament.toggle()
                        }
                    }
                } message: {
                    Text(alertMsg)
                }
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("ButtonColor"))
                    .frame(minWidth: 100,minHeight: 40))
                
            }
        }.onTapGesture{
            hideKeyboard()
        }
    }
}

