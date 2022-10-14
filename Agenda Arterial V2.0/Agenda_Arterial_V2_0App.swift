//
//  Agenda_Arterial_V2_0App.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
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
struct Agenda_Arterial_V2_0App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        let login = FirebaseViewController()
        WindowGroup {
            ContentView().environmentObject(login)
        }
//        .onChange(of: scenePhase) { newScenePhase in
//            if newScenePhase == .background {
//                if (UserDefaults.standard.object(forKey: "sesion")) != nil {
//                    login.getPacient()
//                    
//                }
//            }
//        }
    }
}
