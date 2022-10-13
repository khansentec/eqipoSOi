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
    
    @State private var widthMenu = UIScreen.main.bounds.width
    var body: some View {
        VStack (spacing : 10){
            HStack{
                Text("Nombre: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                TextField("Nombre", text: self.$nameMedicament)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                
            }.padding(.all,20)
            HStack{
                Text("Fecha de inicio: ").padding(.leading, 20).font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                    //
                    .padding(.leading,device == .pad ? 90 : 0)
                DatePicker("", selection: $date, displayedComponents : .date)
                    //
                    .padding(.trailing,device == .pad ? 160 : 0)
                    .scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                
                
            }.padding(.all,20)
            HStack{
                Text("Frecuencia: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                TextField("Frecuencia en horas", text: self.$frecuency)
                    .frame(width : device == .pad ? 270 : 100)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                
            }.padding(.all,20)
            HStack{
                Text("Dosis: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                TextField("Dosis", text: self.$dosis)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                
            }.padding(.all,20)
            HStack{
                Text("Indicaciones: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                TextField("Indicaciones", text: self.$indications)
                    .frame(width : device == .pad ? 200 : 100)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                
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
                    Text("Debe ingresar el nombre del medicamento").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                }
                .foregroundColor(.red)
                .background(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: 1)
                    //.frame(minWidth: 100,minHeight: 40))
                    .frame(minWidth: device == .phone ? 100 : widthMenu == 1024 ? 150 : 150 ,minHeight: device == .phone ? 40 : widthMenu == 1024 ? 50 : 50))
                .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                .padding(.all,20)
                
                
            }
        }.onTapGesture{
            hideKeyboard()
        }
    }
}

