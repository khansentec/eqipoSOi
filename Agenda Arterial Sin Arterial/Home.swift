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
                        AppsView().environment(\.colorScheme, .light).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedicaments()
                                login.getMedics()
                                loginShow.getAppointments()
                            }
                        }
                    case "CapturesView":
                        CapturesView().environment(\.colorScheme, .light).edgesIgnoringSafeArea(.all)
                    case "MedicamentsView":
                        MedicamentsView().environment(\.colorScheme, .light).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedicaments()
                            }
                        }
                    case "WeekReportView":
                        WeekReportView().environment(\.colorScheme, .light).edgesIgnoringSafeArea(.all)
                    case "HealthStateView":
                        HealthStateView().environment(\.colorScheme, .light).edgesIgnoringSafeArea(.all)
                    case "LikYourMedicView":
                        LinkYourMedicView(listMedics: $login.medics).environment(\.colorScheme, .light).edgesIgnoringSafeArea(.all).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                print("reminder: \(loginShow.appointments)")
                                loginShow.getMedics()
                            }
                        }
                    case "RemindersView":
                        RemindersView(remindersList: []).environment(\.colorScheme, .light).edgesIgnoringSafeArea(.all).onAppear{
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                loginShow.getMedics()
                                loginShow.getAppointments()
                            }
                        }
                    case "CapturesRecordsView":
                        CapturesRecordsView()
                    default:
                        AppsView().environment(\.colorScheme, .light).onAppear(){
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedicaments()
                                login.getMedics()
                                loginShow.getAppointments()
                            }
                        }
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
