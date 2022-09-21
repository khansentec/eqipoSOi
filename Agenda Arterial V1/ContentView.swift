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
    @State var medicamentosList : [Medicament] = []
    
    var body: some View {
        
        return Group{
            if loginShow.show == "Home" {
                Home().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "Login"{
                Login().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "CapturesView"{
                CapturesView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "MedicamentsView"{
                MedicamentsView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "WeekReportView"{
                WeekReportView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "RestorePasswordView"{
                RestorePasswordView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "RestoreCodeView"{
                RestoreCodeView().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "ChangePasswordView"{
                ChangePasswordView().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "HealthStateView"{
                HealthStateView().edgesIgnoringSafeArea(.all)
            }
            
        }.onAppear(){
            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = "Home"
            }
        }
        
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
