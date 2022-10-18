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
    
    @State private var alertTittle = ""
    @State private var alertMessage = ""
    
    @StateObject var login = FirebaseViewController()
    @State private var showAlert = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var submitted = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        VStack(alignment : .trailing){
            VStack{
                Button(action: {
                    if editing  {
                        editing = false
                        if info != medicament.information || startDate != medicament.startDate || endDate != medicament.finishDate{
                            let edition = login.checkPastDates(id: medicament.id,finishDate: endDate, startDate: startDate, information: info)
                            submitted = edition.0
                            print(submitted)
                            alertTittle = edition.1
                            alertMessage = edition.2
                        }
                    }else{
                        editing = true
                    }
                }, label: {
                    Image(systemName: editing ? "square.and.arrow.down": "square.and.pencil")
                        .foregroundColor(Color("ButtonColor"))
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text(editing ? "Guadar" : "Editar")
                        .foregroundColor(Color("ButtonColor"))
                        .padding(.top, 3.5)
                    
                }).alert(alertTittle, isPresented: $showAlert){
                    Button("OK"){
                        showAlert = false
                        //si se oprime quitar el ok
                        if submitted{
                            showAlert = false
                            presentationMode.wrappedValue.dismiss()
                        }
                       
                    }
                }message: {
                    Text(alertMessage)
                }
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
                if editing{
                    HStack{
                        Text("Fecha de Fin: ")
                        DatePicker("", selection: $endDate, displayedComponents : .date)
                            .padding(.trailing,70).onAppear{
                                endDate = medicament.finishDate
                            }
                    }
                }
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading).onAppear{
                            info = medicament.information
                        }
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(editing ? Color.gray.opacity(0.2) : Color.clear, lineWidth: 1))
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
            }
            .padding(.trailing,60).padding(.top,10)
                
//            Spacer().frame(maxHeight: widthMenu == 375 ? 170 : 150)
            
        }.onTapGesture {
            hideKeyboard()
        }
        .padding(.top,0)
        .onAppear{
            showNabar = false
        }.onDisappear{
            login.getMedicaments()
            withAnimation{
                showNabar = true
            }
            
        }
    }
}

