//
//  RemindersView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct RemindersView: View {
    @State var remindersList = [Remind]()
    @State var editing = false
    @StateObject var data = FirebaseViewController()
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack {
                Text("Recordatorios").font(.title)
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(remindersList, id : \.id){ reminder in
                            ReminderView(reminder: reminder).onTapGesture {
                                data.sendRemind(item: reminder)
                                editing.toggle()
                            }
                        }.sheet(isPresented: $editing, content: {
                            ReminderDetailsView()
                        }).padding(.all)
                    }
                }.padding(.all)
                    .background(Color.clear)
                    .padding(.bottom,100)
                    .overlay(Group{
                        if remindersList.isEmpty{
                            Text("No hay recordatorios")
                        }
                        
                    })
                
            }
            
        }
    }
}

