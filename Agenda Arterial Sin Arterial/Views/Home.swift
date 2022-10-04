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
                ZStack {
                    ScrollView {
                        VStack {
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "CapturesView"
                                }
                            }){
                                HStack (alignment: .center){
                                    Image(systemName: "arrow.up.heart").resizable().frame(width: 55, height: 50).padding(.trailing,10).foregroundColor(.red)
                                }
                                .frame(width: 70, alignment: .center)
                                Text("Capturas de presión").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black).multilineTextAlignment(.leading)
                                
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90,alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                            
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "MedicamentsView"
                                }
                            }){
                                HStack {
                                    Image(systemName: "pills.fill").resizable().frame(width: 60, height: 50).padding(.trailing,10).foregroundColor(Color("ButtonColor"))
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Medicamentos").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                                
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "WeekReportView"
                                }
                            }){
                                HStack {
                                    Image(systemName: "list.bullet.clipboard").resizable().padding(.trailing,10).foregroundColor(.orange).frame(width: 60, height: 60)
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Reporte semanal").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                                .minimumScaleFactor(0.8)
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "HealthStateView"
                                }
                            }){
                                HStack {
                                    Image(systemName: "stethoscope").resizable().frame(width: 57, height: 50).padding(.trailing,10).foregroundColor(Color("WeekColor"))
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Estado de salud").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "RemindersView"
                                }
                            }){
                                HStack {
                                    Image(systemName: "calendar").resizable().frame(width: 50, height: 50).padding(.trailing,17).foregroundColor(Color("ReportColor"))
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Recordatorios").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            Button(action:{
                                
                            }){
                                HStack {
                                    Image(systemName: "chart.xyaxis.line").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.green)
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Estadísticas semanales").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black).multilineTextAlignment(.leading)
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                            
                            
                            Button(action:{
                                withAnimation{
                                    loginShow.show = "LikYourMedicView"
                                }
                            }){
                                HStack {
                                    Image(systemName: "person").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.gray)
                                }
                                .frame(width: 70, height: 60, alignment: .center)
                                Text("Médicos vinculados").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                                
                            }.fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: widthMenu == 375 ? 350 : 370, height: widthMenu == 375 ? 90 : 90, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
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
                                    .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(Color("ButtonColor"))
                                    .foregroundColor(.white)
                                Text("Menu Principal").foregroundColor(Color("ButtonColor")).font(.system(size:  widthMenu == 375 ? 14 : 16))
                            }
                            Spacer()
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .leading){
                            ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "GDV", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 20 : 22)
                            Spacer()
                            Button(action: {
                                loginShow.show = "Login"
                            }){
                                Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(Color("ButtonColor"))
                            }
                            .padding(.all)
                            .padding(.leading, 30)
                            .padding(.bottom, 20)
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu-200)
                    .background(Color("BlueBBVA"))
                }
            }
        }
    }
}


