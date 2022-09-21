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
                            HStack{
                                Button(action:{
                                    withAnimation{
                                        loginShow.show = "CapturesView"
                                    }
                                }){
                                    Image(systemName: "arrow.up.heart").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                    Text("Captura tu Presion").font(.system(size: widthMenu == 375 ? 25 : 22)).bold()
                                        
                                }.fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(Color("RedSoft")).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                            
                           
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "MedicamentsView"
                                }
                            }){
                                Image(systemName: "pills.fill").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Tus Medicamentos").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                                    
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                
                            }){
                                Image(systemName: "list.bullet.clipboard").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Reporte Semanal").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                
                            }){
                                Image(systemName: "stethoscope").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Tu Estado de Salud").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "calendar").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 60)
                                Text("Calendario").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "chart.xyaxis.line").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 50)
                                Text("Estadisticas Semanales").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "person").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 10)
                                Text("Medico Vinculado").font(.system(size: widthMenu == 375 ? 25 : 21)).bold()
                                
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 180, height: widthMenu == 375 ? 90 : 190)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                        }
                        
                    }
                    
                }
                
            }.background(.white).onTapGesture {
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
                    }.frame(width: widthMenu-200).background(Color("BlueBBVA"))
                }
                
            }
            
        }
    }
}


