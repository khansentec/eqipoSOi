//
//  MedicamentDetailsView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 20/09/22.
//

import SwiftUI

struct MedicamentDetailsView: View {
    
    @State var editando = false
    @State var fechaInicio : Date
    @State var medicamento : Medicament
    @State var info : String
    
    @Binding var showNavbar : Bool
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    
    
    var body : some View {
        VStack(alignment : .trailing){
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
                HStack {
                    Text("Fecha de inicio: ")
                    DatePicker("", selection: $fechaInicio, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editando)
                }
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading)
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
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
            }
            .padding(.trailing,60).padding(.top,10)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .padding(.top,0)
        .onAppear{
            showNavbar = false
        }
        .onDisappear{
            showNavbar = true
        }
        Spacer().frame(maxHeight: widthMenu == 375 ? 170 : 150)
    }
}
