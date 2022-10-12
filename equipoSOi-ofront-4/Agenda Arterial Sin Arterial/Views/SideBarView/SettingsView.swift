//
//  SettingsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var index = "Configuración"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heightMenu = UIScreen.main.bounds.height
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State var notConsultas = true
    @State var notMediciones = true
    @State var notReporteSemanal = true
    @State var notReporteSalud = true
    
    var device = UIDevice.current.userInterfaceIdiom
    
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                VStack(spacing: 10){
                    Text("Configuraciones").font(.system(size: device == .pad ? 35: widthMenu == 375 ? 20 : 20)).bold()
                    
                    Toggle(isOn: $notConsultas) {
                        Text("Consultas").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                    }.padding()
                        //.frame(width:250)
                        .frame(width: device == .pad ? 550 : 250)
                    Toggle(isOn: $notMediciones) {
                        Text("Mediciones").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                    }.padding()
                        .frame(width: device == .pad ? 550 : 250)
                    Toggle(isOn: $notReporteSemanal) {
                        Text("Reporte Semanal").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                    }.padding()
                        .frame(width: device == .pad ? 550 : 250)
                    Toggle(isOn: $notReporteSalud) {
                        Text("Reporte de Salud").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                    }.padding()
                        .frame(width: device == .pad ? 550 : 250).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                }
                Spacer()
                
            }.onTapGesture {
                withAnimation{
                    menu = false
                }
                hideKeyboard()
            }
            if menu{
                HStack{
                    VStack{
                        HStack{
                            Button(action: {
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "arrow.left")
                                    .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(.blue)
                                    .foregroundColor(.white)
                                Text("Datos Generales").foregroundColor(.blue).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
                            }
                            Spacer()
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .leading){
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 25 : 32).padding(.bottom,10)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "SettingsView", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 16)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "GeneralDataView", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            Spacer()
                            Button(action: {
                                
                                loginShow.show = "Login"
                            }){
                                Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(.blue)
                            }.padding(.all).padding(.leading, 30).padding(.bottom, 20)
                        }
                        Spacer()
                    }.frame(width: widthMenu-200).background(Color("BlueBBVA"))
                }
                
            }
        }
    }
}


