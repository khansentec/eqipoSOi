//
//  ReminderDetailsView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Katie Hansen on 10/1/22.
//

import SwiftUI

struct ReminderDetailsView: View {
    
    @Binding var showNavbar : Bool
    
    var body: some View {
        
        VStack {
            Text("Detalles del recordatorio aquí")
        }
        .padding(.top,0)
        .onAppear{
            showNavbar = false
        }
        .onDisappear{
            showNavbar = true
        }
    }
}
