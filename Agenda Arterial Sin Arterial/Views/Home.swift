//
//  Home.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 17/09/22.
//

import SwiftUI

struct Home: View {
    
    @State private var index = "Menu Principal"
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
                                    Text("Captura tu Presion").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                                        
                                }.fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(Color("RedSoft")).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                            
                           
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "MedicamentsView"
                                }
                            }){
                                Image(systemName: "pills.fill").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Tus Medicamentos").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                                    
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "WeekReportView"
                                }
                            }){
                                Image(systemName: "list.bullet.clipboard").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Reporte Semanal").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "HealthStateView"
                                }
                            }){
                                Image(systemName: "stethoscope").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Text("Tu Estado de Salud").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "RemindersView"
                                }
                            }){
                                Image(systemName: "calendar").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 60)
                                Text("Calendario").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "chart.xyaxis.line").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 50)
                                Text("Estadisticas Semanales").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "LikYourMedicView"
                                }
                            }){
                                Image(systemName: "person").resizable().frame(width: 50, height: 50).padding(.trailing,10)
                                Spacer().frame(maxWidth: 10)
                                Text("Medico Vinculado").font(.system(size: widthMenu == 375 ? 25 : 30)).bold()
                                
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90)
                                .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                        }
                        
                    }.padding(.all)
                    
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
                                Text("Menu Principal").foregroundColor(.blue).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
                            }
                            Spacer()
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .leading){
                            ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 20 : 22)
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


