//
//  Home.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

struct Home: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var index = "Menu Principal"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var showApp = "Home"
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack {
                
                NavBarHome(menu: $menu, index: $index)
                
                ZStack{
                    switch loginShow.showApp{
                    case "Home":
                        AppsView().onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedicaments()
                                
                            }
                        }
                    case "CapturesView":
                        CapturesView().edgesIgnoringSafeArea(.all)
                    case "MedicamentsView":
                        MedicamentsView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedicaments()
                            }
                        }
                    case "WeekReportView":
                        WeekReportView().edgesIgnoringSafeArea(.all)
                    case "HealthStateView":
                        HealthStateView().edgesIgnoringSafeArea(.all)
                    case "LikYourMedicView":
                        LinkYourMedicView(listMedics: $login.medics).edgesIgnoringSafeArea(.all).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedics()
                            }
                        }
                    case "RemindersView":
                        RemindersView(remindersList: [], medics: $login.medics).edgesIgnoringSafeArea(.all).onAppear{
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedics()
                            }
                        }
                    default:
                        AppsView()
                    }
                }
                
            }
            .background(.white)
            .onTapGesture {
                withAnimation{
                    menu = false
                }
            }
            if menu{
                 NavBarMenu(index: $index, menu: $menu)
            }
            
        }
    }
}
