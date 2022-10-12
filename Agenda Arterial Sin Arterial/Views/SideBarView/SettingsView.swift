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
    @StateObject var login = FirebaseViewController()
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
                        .frame(width:250)
                    Toggle(isOn: $notMediciones) {
                        Text("Mediciones")
                    }.padding()
                        .frame(width:250)
                    Toggle(isOn: $notReporteSemanal) {
                        Text("Reporte Semanal")
                    }.padding()
                        .frame(width:250)
                    Toggle(isOn: $notReporteSalud) {
                        Text("Reporte de Salud")
                    }.padding()
                        .frame(width:250)
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
                    }
                }
                .popover(isPresented: $presentCredits, content: { CreditsView() })
                .padding(.bottom, 100)
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


