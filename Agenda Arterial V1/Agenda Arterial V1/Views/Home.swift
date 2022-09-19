//
//  Home.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 17/09/22.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @State private var index = ""
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu: $menu)
                ZStack{
                    ScrollView{
                        VStack{
                            HStack(spacing : 10){
                                Button(action:{
                                    
                                }){
                                    Text("Captura tu Presion")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                }
                                Button(action:{
                                    
                                }){
                                    Text("Tus Medicamentos")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 21)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(0.8)
                                }
                            }
                            HStack(spacing : 10){
                                Button(action:{
                                    
                                }){
                                    Text("Reporte Semanal")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                }
                                Button(action:{
                                    
                                }){
                                    Text("Tu Estado de Salud")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(0.8)
                                }
                            }
                            HStack(spacing : 10){
                                Button(action:{
                                    
                                }){
                                    Text("Calendario")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                }
                                Button(action:{
                                    
                                }){
                                    Text("Estadisticas Semanales")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding().font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 172 : 180, height: widthMenu == 375 ? 140 : 190)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(0.8)
                                }
                            }
                            HStack(spacing : 10){
                                Button(action:{
                                    
                                }){
                                    Text("Medico Vinculado")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .font(.system(size: widthMenu == 375 ? 18 : 22)).bold()
                                        .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 80 : 110)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            }.onTapGesture {
                withAnimation{
                    menu = false
                }
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
                                Text("Configuraciones").foregroundColor(.blue).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
                            }
                            Spacer()
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .center){
                            ButtonNavbar(index: $index, menu: $menu, title: "Apartado 1")
                            ButtonNavbar(index: $index, menu: $menu, title: "Apartado 2")
                            ButtonNavbar(index: $index, menu: $menu, title: "Apartado 3")
                            
                             Button(action: {
                             try! Auth.auth().signOut()
                             UserDefaults.standard.removeObject(forKey: "sesion")
                             loginShow.show = "Login"
                             }){
                             Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(.white)
                             }
                        }
                        Spacer()
                    }.frame(width: widthMenu-200).background(Color("BackgroundColorSide"))
                }
                
            }
            
        }
    }
}


