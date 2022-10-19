//
//  ReminderDetailsView.swift
//  Agenda Arterial V2.0
//
//  Created by Katie Hansen on 10/1/22.
//
import SwiftUI

struct ReminderDetailsView: View {
    @State var editing = false
    @State var date = Date.now
    @State var reminder : Remind
    @State var info = "No hay info"
    @Binding var showNabar : Bool
    @State var medicForAppointment : Medic!
    @State var appoinment : AppointmentRecord!
    @State private var alertTittle = ""
    @State private var alertMessage = ""
    @EnvironmentObject var loginShow : FirebaseViewController
    @StateObject var login = FirebaseViewController()
    @State private var showAlert = false
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var submitted = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        VStack(alignment : .trailing){
            VStack{
                if reminder.type == "consulta"{
                    Button(action: {
                        if editing  {
                            editing = false
                            
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
                }
            }.padding(.trailing,60).padding(.top,0)
            
            VStack(alignment : .leading, spacing : 20){
                Text(reminder.title)
                    .font(.system(.title))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider().frame(width : 250)
                
                if reminder.type == "consulta"{
                    
                    
                    VStack(alignment: .center){
                        
                        Text(medicForAppointment.name+" "+medicForAppointment.patName+" "+medicForAppointment.matName)
                            .font(.title2)
                            .minimumScaleFactor(0.9)
                            .foregroundColor(Color("ButtonColor"))
                            .padding(.bottom, 2)
                        Text("Cédula Profesional: \(medicForAppointment.proflicense)" )
                            .lineLimit(1).padding(.bottom, 2)
                        if medicForAppointment.phone != "no phone"{
                            Text("Número de teléfono: ")
                            Link("+ \(medicForAppointment.phone)", destination: URL(string: "tel:\(medicForAppointment.phone)")!)
                        }
                    }.padding(.leading, 30)
                }
                
                HStack{
                    Text("Fecha: ")
                    DatePicker("", selection: $date)
                        .padding(.trailing,70).disabled(!editing).onAppear{
                            date = reminder.date
                        }
                }
                
                HStack{
                    TextEditor(text: $info)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading).onAppear{
                            info = reminder.description
                        }
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editing ? Color.gray.opacity(0.2) : Color.clear, lineWidth: 1))
                .disabled(!editing)
                
            }.padding(.leading, 60)
            
            VStack{
                
                Button(action: {
                    print(reminder)
                    login.deleteData(collectionName: "notificaciones", id: reminder.id){
                        (done) in
                        if done{
                            print("succesfully delete")
                        }
                    }
                    if reminder.type == "consulta"{
                        login.deleteAppointment(id: reminder.idconsulta){
                            (done)in
                            if done{
                                print("succesfully delete appointment")
                            }
                        }
                    }
                    
                    login.getReminds()
                    presentationMode.wrappedValue.dismiss()
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
            login.getReminds()
            withAnimation{
                showNabar = true
            }
            
        }
    }
}
