//
//  ContentView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 16/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginShow : FirebaseViewController
    @State private var index = "Apartado 1"
    @State private var menu = false
    
    var body: some View {
        /*
        return Group{
            if loginShow.show == "Home" {
                //Home().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "Login"{
                //Login()
            }
        }.onAppear(){
            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = "Home"
            }
        }*/
//        Login()
//       Home()
//       CapturesView()
        
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
