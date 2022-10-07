//
//  AddMedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct AddMedicamentView: View {
    @Binding var medsList : [Medicament]
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    @State var nameMedicament = ""
    @State var date = Date.now
    @State var frecuency = ""
    @State var dosis = ""
    @State var indications = ""
    @State var idPacient = "12345"
    
    @Binding var addMedicament : Bool
    @State var edit = false
    @State var error = false
    
    var body: some View {
        VStack (spacing : 10){
            HStack{
                Text("Nombre: ")
                TextField("Nombre", text: self.$nameMedicament)
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
                Button("Enviar") {
                    let information = "Frecuencia en horas : " + frecuency + "\nDosis : " + dosis + "\nIndicaciones : " + indications
                    
                    if nameMedicament != ""{
                        self.medsList.append(Medicament(idPacient: idPacient, medicamentName: nameMedicament, information: information, startDate: date, forgetTimes: 0))
                        
                        self.addMedicament.toggle()
                        
                    }else{
                        error = true
                    }
                    
                }.alert("Error", isPresented: $error){
                    
                    Button("OK"){
                        //si se oprime quitar el ok
                    }
                } message: {
                    Text("Debe ingresar el nombre del medicamento")
                }
                .foregroundColor(.red)
                .background(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: 1)
                    .frame(minWidth: 100,minHeight: 40))
                
                
            }
        }.onTapGesture{
            hideKeyboard()
        }
    }
}

