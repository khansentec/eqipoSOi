//
//  MedicamentDetailsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentDetailsView: View {
    @State var editing = false
    @State var startDate = Date.now
    @State var endDate = Date.now
    @State var medicament : Medicament
    @State var info = "No hay info"
    
    @Binding var showNabar : Bool

    @StateObject var login = FirebaseViewController()
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        VStack(alignment : .trailing){
            VStack{
                Button(action: {
                    if editing {
                        editing = false
                        login.checkPastDates(id: medicament.id,finishDate: endDate, startDate: startDate, information: info)
                    }else{
                        editing = true
                    }
                    
                }, label: {
                    Image(systemName: editing ? "square.and.arrow.down": "square.and.pencil")
                        .foregroundColor(.blue)
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text(editing ? "Guadar" : "Editar")
                        .foregroundColor(.blue)
                        .padding(.top, 3.5)
                    
                })
            }.padding(.trailing,60).padding(.top,0)
            
            VStack(alignment : .leading, spacing : 20){
                Text(medicament.medicamentName)
                    .font(.system(.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider().frame(width : 250)
                HStack{
                    Text("Fecha de inicio: ")
                    DatePicker("", selection: $startDate, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editing).onAppear{
                            startDate = medicament.startDate
                        }
                }
                HStack{
                    Text("Fecha de Fin: ")
                    DatePicker("", selection: $endDate, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editing).onAppear{
                            endDate = medicament.finishDate
                        }
                }
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading).onAppear{
                            info = medicament.information
                        }
                    
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editing ? Color.gray : Color.clear, lineWidth: 1))
                    .disabled(!editing)
                
            }.padding(.leading, 60)
            
            VStack{
                Button(action: {
                    var sendDate = endDate
                    if medicament.startDate >= sendDate{
                        sendDate = Date()
                    }
                    login.disableMedicament(idMedicament: medicament.id, endDate: sendDate){
                        (done) in
                            if done{
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
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
                
            
//            Spacer().frame(maxHeight: widthMenu == 375 ? 170 : 150)
        }.onTapGesture {
            hideKeyboard()
        }
        
        .padding(.top,0).onAppear{
            showNabar = false
        }.onDisappear{
            login.getMedicaments()
            withAnimation{
                showNabar = true
            }
            
        }
        
    }
}

