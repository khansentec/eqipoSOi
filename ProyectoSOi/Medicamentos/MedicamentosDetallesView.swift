//
//  MedicamentosDetallesView.swift
//  ProyectoSOi
//
//  Created by alumno on 19/09/22.
//

import SwiftUI
import UIKit

struct MedicamentoDetallesView: View{
    @State var info = ""
    @State var fechaInicio : Date
    @State var medicamento : Medicamento
    @State var editando = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    init( medicamento : Medicamento, info : String){
        _medicamento = State(initialValue: medicamento)
        _fechaInicio = State(initialValue: medicamento.fechaInicio)
        _info = State(initialValue: medicamento.informacion)
    }
    
    var body : some View {
        VStack(alignment : .trailing, spacing: 0){
            VStack{
                Button(action: {
                    if editando {
                        editando = false
                    }else{
                        editando = true
                    }
                }, label: {
                    Image(systemName: editando ? "square.and.arrow.down": "square.and.pencil")
                        .foregroundColor(.blue)
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text(editando ? "Guadar" : "Editar")
                        .foregroundColor(.blue)
                        .padding(.top, 3.5)
                    
                })
            }.padding(.trailing,60).padding(.top,0)
                
            VStack(alignment : .leading, spacing : 20){
                Text(medicamento.nombreMedicamento)
                    .font(.system(.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider().frame(width : 250)
                HStack{
                    Text("Fecha de inicio: ")
                    DatePicker("", selection: $fechaInicio, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editando)
                }
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: device == .pad ? 240 : 200, maxHeight: 300, alignment: .leading)
                        
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editando ? Color.gray : Color.clear, lineWidth: 1))
                .disabled(!editando)
                    
            }.padding(.leading, 60)
            
            VStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text("Eliminar")
                        .foregroundColor(.red)
                        .padding(.top, 3.5)
                    
                })
            }.padding(.trailing,60).padding(.top,10)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .border(.red)
        .padding(.top,0)
    }
}

extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

