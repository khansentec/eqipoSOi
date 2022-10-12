//
//  Agenda_Arterial_Sin_ArterialApp.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 25/09/22.
//

import SwiftUI

@main
struct Agenda_Arterial_Sin_ArterialApp: App {
    
    var body: some Scene {
        let login = FirebaseViewController()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
