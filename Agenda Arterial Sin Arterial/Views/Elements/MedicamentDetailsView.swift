//
//  MedicamentDetailsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentDetailsView: View {
    @State var editing = false
    @State var startDate : Date
    @State var medicament : Medicament
    @State var info : String
    
    @Binding var showNavbar : Bool
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    
    
    var body : some View {
        VStack(alignment : .trailing){
            VStack{
                Button(action: {
                    if editing {
                        editing = false
                    }else{
                        editing = true
                    }
                }, label: {
<<<<<<< HEAD
                    Image(systemName: editando ? "square.and.arrow.down": "square.and.pencil")
                        .foregroundColor(Color("ButtonColor"))
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text(editando ? "Guadar" : "Editar")
                        .foregroundColor(Color("ButtonColor"))
=======
                    Image(systemName: editing ? "square.and.arrow.down": "square.and.pencil")
                        .foregroundColor(.blue)
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text(editing ? "Guadar" : "Editar")
                        .foregroundColor(.blue)
>>>>>>> ofront
                        .padding(.top, 3.5)
                    
                })
            }.padding(.trailing,60).padding(.top,0)
            
            VStack(alignment : .leading, spacing : 20){
                Text(medicament.medicamentName)
                    .font(.system(.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider().frame(width : 250)
                HStack {
                    Text("Fecha de inicio: ")
                    DatePicker("", selection: $startDate, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editing)
                }
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading)
                    
<<<<<<< HEAD
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editando ? Color.gray : Color.clear, lineWidth: 1))
                .disabled(!editando)
=======
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editing ? Color.gray : Color.clear, lineWidth: 1))
                    .disabled(!editing)
>>>>>>> ofront
                
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
<<<<<<< HEAD
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
=======
            }.padding(.trailing,60).padding(.top,10)
                
            
//            Spacer().frame(maxHeight: widthMenu == 375 ? 170 : 150)
        }.onTapGesture {
            hideKeyboard()
        }
        
        .padding(.top,0).onAppear{
            showNabar = false
        }.onDisappear{
            withAnimation{
                showNabar = true
            }
            
>>>>>>> ofront
        }
        
    }
}

