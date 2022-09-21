//
//  AddMedicamentView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 20/09/22.
//

import SwiftUI

struct AddMedicamentView: View {
    
    @Binding var medicamentosList : [Medicament] 
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    @State var nombreMedicamento = ""
    @State var fecha = Date.now
    @State var frecuencia = ""
    @State var dosis = ""
    @State var indicaciones = ""
    @State var idPaciente = "12345"
    
    @Binding var agregarMedicamento : Bool
    @State var editar = false
    @State var alerta = false
    
    var body: some View {
        VStack (spacing : 10){
            HStack{
                Text("Nombre: ")
                TextField("Nombre", text: self.$nombreMedicamento)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Text("Fecha de inicio: ").padding(.leading, 20)
                DatePicker("", selection: $fecha, displayedComponents : .date)
                    .padding(.trailing,70)
                
            }.padding(.all,20)
            HStack{
                Text("Frecuencia: ")
                TextField("Frecuencia en horas", text: self.$frecuencia)
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
                TextField("Indicaciones", text: self.$indicaciones)
                    .frame(width : device == .pad ? 150 : 100)
                    .textFieldStyle(.roundedBorder)
            }.padding(.all,20)
            HStack{
                Button("Enviar") {
                    let informacion = "Frecuencia en horas : " + frecuencia + "\nDosis : " + dosis + "\nIndicaciones : " + indicaciones
                    
                    if nombreMedicamento != ""{
                        self.medicamentosList.append(Medicament( idPaciente: idPaciente, nombreMedicamento: nombreMedicamento, informacion: informacion, fechaInicio: fecha, vecesOlvidado: 0))
                        
                        self.agregarMedicamento.toggle()
                        
                    }else{
                        alerta = true
                    }
                    
                }.alert("Error", isPresented: $alerta){
                    
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
        }
    }
}

