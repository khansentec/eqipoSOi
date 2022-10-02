//
//  RemindersViews.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct RemindersViews: View {
    // Lista de recordatorios heredada de la llamada a VistaCalendario
    @State var remindersList = [Remind]()
    
    @State var showNavbar = true
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            VStack {
                if showNavbar {
                    NavBarViews()
                }
                NavigationView {
                    
                    List() {
                        ForEach(remindersList, id : \.id){
                            reminder in
                            
                            NavigationLink(destination:ReminderDetailsView(showNavbar: $showNavbar), label: {
                                ReminderView(reminder: reminder)
                            })
                            .background(Color.clear)
                        }
                    }
                    .padding(.all)
                        .background(Color.clear)
                        .padding(.bottom,100)
                        .overlay(Group{
                        if remindersList.isEmpty{
                            Text("No hay medicamentos")
                        }
                    })
                    .navigationBarTitle("Recordatorios", displayMode: .inline)
                    
                }
            }
        }
    }
}

