//
//  ReminderDetailsView.swift
//  Agenda Arterial V2.0
//
//  Created by Katie Hansen on 10/1/22.
//
import SwiftUI

struct ReminderDetailsView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack {
            Text("Detalles del recordatorio aquí").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
        }
        .padding(.top,0)
    }
}
