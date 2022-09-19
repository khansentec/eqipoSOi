//
//  Agenda_Arterial_V1App.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 16/09/22.
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
struct Agenda_Arterial_V1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        let login = FirebaseViewController()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
