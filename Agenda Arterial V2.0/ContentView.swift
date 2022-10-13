//
//  ContentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var loginShow : FirebaseViewController
    @StateObject var login = FirebaseViewController()
    
    var body: some View {
        
        
        let ejemplosPreguntas = [
            ["P: ¿Cómo puedo cerrer una sesión?", "R: Da clic en el butón 'Cerrar sesión'."],
            ["P: No tengo un médico vinculado. ¿Cómo puedo conseguir uno?", "R: Naviga a la página de Médico vinculado y da clic en el búton 'Registrar'."]
        ]
        
        return Group{
            
            switch loginShow.show{
            case "Home":
                Home().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        login.getMedicaments()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
                
            case "Login":
                Login().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            case "SignIn":
                SignIn().edgesIgnoringSafeArea(.all).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
            case "FrecuentlyAskedQuestionsView":
                FrecuentlyAskedQuestions(questionList: ejemplosPreguntas).edgesIgnoringSafeArea(.all).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
            case "GeneralDataView":
                GeneralDataView(data: $login.data).edgesIgnoringSafeArea(.all).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
            case "SettingsView":
                SettingsView().edgesIgnoringSafeArea(.all).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
            default:
                Login().edgesIgnoringSafeArea(.all).onAppear{
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getPacient()
                        loginShow.getPacient()
                        print("Login: \(loginShow.data.name)")
                    }
                }
            }
            
            
            
            
        }.onAppear(){
            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = "Home"
                loginShow.showApp = "Home"
                
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
