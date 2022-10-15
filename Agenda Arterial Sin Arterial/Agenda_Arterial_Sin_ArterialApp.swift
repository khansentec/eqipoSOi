//
//  Agenda_Arterial_Sin_ArterialApp.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 25/09/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Agenda_Arterial_Sin_ArterialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        let login = FirebaseViewController()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
