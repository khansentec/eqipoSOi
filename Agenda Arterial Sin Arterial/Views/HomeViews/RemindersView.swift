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
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack {
                
                ScrollView(.vertical, showsIndicators: false){
                    Text("Recordatorios").font(.title)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(data.reminds.sorted(by: { $0.date.compare($1.date) == .orderedAscending }), id : \.self){ reminder in
                            ReminderView(reminder: reminder).onTapGesture {
                                data.sendRemind(item: reminder)
                                editing.toggle()
                            }
                        }.sheet(isPresented: $editing, content: {
                            ReminderDetailsView()
                        }).padding(.all)
                    }
                }.onAppear{
                    data.getReminds()
                }.padding(.all)
                    .background(Color.clear)
                    .padding(.bottom,100)
                    .overlay(Group{
                        if data.reminds.isEmpty{
                            Text("No hay recordatorios")
                        }
                        
                    })
                
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
                data.getMedicaments()
            }content:{
                AddAppointment(medics: $medics, addAppointment: $addAppoinment)
            }
        }.onAppear{
            showNavbar = true
            data.getReminds()
        }
    }
}

