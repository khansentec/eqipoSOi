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
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack {
                Text("Recordatorios").font(.system(size: device == .pad ? 35: widthMenu == 375 ? 20 : 20)).bold()
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(remindersList, id : \.id){ reminder in
                            ReminderView(reminder: reminder).onTapGesture {
                                data.sendRemind(item: reminder)
                                editing.toggle()
                            }.font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        }.sheet(isPresented: $editing, content: {
                            ReminderDetailsView()
                        }).padding(.all)
                    }
                }.padding(.all)
                    .background(Color.clear)
                    .padding(.bottom,100)
                    .overlay(Group{
                        if remindersList.isEmpty{
                            Text("No hay recordatorios").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        }
                        
                    })
                
            }
            
        }
    }
}

