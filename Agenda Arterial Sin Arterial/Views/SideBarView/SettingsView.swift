//
//  SettingsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var index = "SettingsView"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heightMenu = UIScreen.main.bounds.height
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State var notConsultas = true
    @State var notMediciones = true
    @State var notReporteSemanal = true
    @State var notReporteSalud = true
    
    @State private var presentCredits = false
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                VStack(spacing: 10){
                    Text("Configuraciones").bold().font(.title)
                    
                    Toggle(isOn: $notConsultas) {
                        Text("Consultas")
                    }.padding()
                        .frame(width:250).onAppear{
                            let notificationAppoinments = UserDefaults.standard.object(forKey: "showAppoinment") as? Bool ?? true
                            notConsultas = notificationAppoinments
                        }
                    Toggle(isOn: $notMediciones) {
                        Text("Mediciones")
                    }.padding()
                        .frame(width:250).onAppear{
                           let notificationMeditions = UserDefaults.standard.object(forKey: "showMeditions") as? Bool ?? true
                            notMediciones = notificationMeditions
                        }
                    Toggle(isOn: $notReporteSemanal) {
                        Text("Reporte Semanal")
                    }.padding()
                        .frame(width:250).onAppear{
                           let notificationWeekReport = UserDefaults.standard.object(forKey: "showWeekReport") as? Bool ?? true
                            notReporteSemanal = notificationWeekReport
                        }
                    Toggle(isOn: $notReporteSalud) {
                        Text("Reporte de Salud")
                    }.padding()
                        .frame(width:250).onAppear{
                            let notificationHealhtreport = UserDefaults.standard.object(forKey: "showHealtReport") as? Bool ?? true
                            notReporteSalud = notificationHealhtreport
                        }
                }
                Spacer()
                
                VStack(alignment: .trailing){
                    Button(action: { presentCredits.toggle() }) {
                        HStack {
                            Text("Créditos")
                                .foregroundColor(Color("ButtonColor"))
                                .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold))
                                .underline()
                        }
                    }.popover(isPresented: $presentCredits){
                        CreditsView()
                    }
                }
                
                .padding(.bottom, 100)
            }.onDisappear{
                if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                    UserDefaults.standard.set(notReporteSalud, forKey: "showHealtReport")
                    UserDefaults.standard.set(notConsultas, forKey: "showAppoinment")
                    UserDefaults.standard.set(notReporteSemanal, forKey: "showWeekReport")
                    UserDefaults.standard.set(notMediciones, forKey: "showMeditions")
                }
            }
            
            if menu {
                NavBarMenu(index: $index, menu: $menu)
            }
            
        }
        .onTapGesture {
            withAnimation{
                menu = false
            }
            hideKeyboard()
        }
    }
}


