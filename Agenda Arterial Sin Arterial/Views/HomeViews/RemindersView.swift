//
//  RemindersView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct RemindersView: View {
    @State var remindersList = [Remind]()
    @Binding var medics : [Medic]
    @State var editing = false
    @StateObject var data = FirebaseViewController()
    
    @State var showNavbar = true
    @State var addAppoinment = false
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack{
                
                Text("Recordatorios").font(.title)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 15){
                        ForEach(data.reminds.sorted(by: { $0.date.compare($1.date) == .orderedAscending }), id : \.self){
                            reminder in
                            ReminderView(reminder: reminder).onTapGesture {
                                if reminder.type == "consulta" || reminder.type == "medicion"{
                                    data.sendRemind(item: reminder)
                                    editing.toggle()
                                }
                            }
                        }
                        .sheet(isPresented: $editing){
                            data.getReminds()
                        } content: {
                            ReminderDetailsView(reminder: data.remindUpdate, showNabar: $showNavbar)
                        }
                    }
                    .background(Color.clear)
                    .padding(.bottom,100)
                    .overlay(Group{
                        if data.reminds.isEmpty{
                            Text("No hay recordatorios")
                        }
                        
                    })
                }.onAppear{
                    data.getReminds()
                    for remind in data.reminds{
                        print(remind.date)
                    }
                    print(data.reminds.count)
                }
            }
            Button(action: {
                self.addAppoinment.toggle()
            }){
                Image(systemName: "plus").font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.white).padding(.bottom,40).padding(.trailing,40).frame(width: 100, height: 100)
            }
            .background{
                Circle().fill(Color("ButtonColor")).padding(.bottom,40).padding(.trailing,40)
            }.opacity(showNavbar ? 1 : 0).sheet(isPresented: $addAppoinment){
                data.getReminds()
            }content:{
                AddAppointment(medics: $medics, addAppointment: $addAppoinment)
            }
        }.onAppear{
            showNavbar = true
        }
    }
}

