//
//  AppsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 05/10/22.
//

import SwiftUI
import Firebase

struct AppsView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @State private var index = "Menu Principal"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var showApp = "Home"
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        if device == .pad{
            ScrollView{
                HStack{
                    Button(action:{
                        withAnimation{
                            loginShow.showApp = "CapturesView"
                        }
                    }){
                        VStack{
                            Image(systemName: "arrow.up.heart").resizable().frame(width: 55, height: 50).padding(.trailing,10).foregroundColor(.red)
                            Text("Captura tu Presion").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                        
                        
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                    
                    Button(action:{
                        withAnimation{
                            loginShow.showApp = "MedicamentsView"
                        }
                    }){
                        VStack{
                            Image(systemName: "pills.fill").resizable().frame(width: 60, height: 50).padding(.trailing,10).foregroundColor(.blue)
                            Text("Tus Medicamentos").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .minimumScaleFactor(0.8)
                    Button(action:{
                        withAnimation{
                            loginShow.showApp = "WeekReportView"
                        }
                    }){
                        VStack{
                            Image(systemName: "list.bullet.clipboard").resizable().padding(.trailing,10).foregroundColor(.orange).frame(width: 65, height: 60)
                            Text("Reporte Semanal").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .minimumScaleFactor(0.8)
                    
                }
                HStack{
                    Button(action:{
                        withAnimation{
                            loginShow.showApp = "HealthStateView"
                        }
                    }){
                        VStack{
                            Image(systemName: "stethoscope").resizable().frame(width: 57, height: 50).padding(.trailing,10).foregroundColor(Color("WeekColor"))
                            Text("Tu Estado de Salud").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    
                    Button(action:{
                        login.getReminds()
                        withAnimation{
                            loginShow.showApp = "RemindersView"
                        }
                    }){
                        VStack{
                            Image(systemName: "calendar").resizable().frame(width: 50, height: 50).padding(.trailing,17).foregroundColor(Color("ReportColor"))
                            Text("Recordatorios").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    Button(action:{
                        
                    }){
                        VStack{
                            Image(systemName: "chart.xyaxis.line").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.green)
                            Text("Estadisticas Semanales").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                        }
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 260, height: 260, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    
                }
                
                Button(action:{
                    
                    if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                        login.getMedics()                    }
                    withAnimation{
                        loginShow.showApp = "LikYourMedicView"
                    }
                }){
                    VStack{
                        Image(systemName: "person").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.gray)
                        Spacer().frame(maxWidth: 10)
                        Text("Medico Vinculado").font(.system(size: widthMenu == 375 ? 25 : 30)).bold().foregroundColor(.black)
                    }
                }.fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 260, height: 260, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.8)
                
                
                
                
            }.padding(.all)
        }else{
            ScrollView{
                VStack{
                    
                    Button(action:{
                        print("Desde view heart: \(login.meds)")
                        withAnimation{
                            loginShow.showApp = "CapturesView"
                        }
                    }){
                        HStack (alignment: .center){
                            Image(systemName: "arrow.up.heart").resizable().frame(width: 55, height: 50).padding(.trailing,10).foregroundColor(.red)
                        }
                        .frame(width: 70, alignment: .center)
                        Text("Capturas de presión").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black).multilineTextAlignment(.leading)
                        
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90,alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                    
                    Button(action:{
                        login.getMedicaments()
                        
                        withAnimation{
                            loginShow.showApp = "MedicamentsView"
                        }
                    }){
                        HStack {
                            Image(systemName: "pills.fill").resizable().frame(width: 60, height: 50).padding(.trailing,10).foregroundColor(Color("ButtonColor"))
                        }
                        .frame(width: 70, height: 60, alignment: .center)
                        Text("Medicamentos").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                        
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .minimumScaleFactor(0.8)
                    Button(action:{
                        login.getMedicaments()
                        withAnimation{
                            loginShow.showApp = "WeekReportView"
                        }
                    }){
                        HStack {
                            Image(systemName: "list.bullet.clipboard").resizable().padding(.trailing,10).foregroundColor(.orange).frame(width: 60, height: 60)
                        }
                        .frame(width: 70, height: 60, alignment: .center)
                        Text("Reporte semanal").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .minimumScaleFactor(0.8)
                    Button(action:{
                        withAnimation{
                            loginShow.showApp = "HealthStateView"
                        }
                    }){
                        HStack {
                            Image(systemName: "stethoscope").resizable().frame(width: 57, height: 50).padding(.trailing,10).foregroundColor(Color("WeekColor"))
                        }
                        .frame(width: 70, height: 60, alignment: .center)
                        Text("Estado de salud").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    
                    Button(action:{
                        login.getReminds()
                        withAnimation{
                            loginShow.showApp = "RemindersView"
                        }
                    }){
                        HStack {
                            Image(systemName: "calendar").resizable().frame(width: 50, height: 50).padding(.trailing,17).foregroundColor(Color("ReportColor"))
                        }
                        .frame(width: 70, height: 60, alignment: .center)
                        Text("Recordatorios").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
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
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    
                    Button(action:{
                        if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                            login.getMedics()
                            print(login.medics)
                        }
                        withAnimation{
                            loginShow.showApp = "LikYourMedicView"
                        }
                    }){
                        
                        HStack {
                            Image(systemName: "person").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.gray)
                        }
                        .frame(width: 70, height: 60, alignment: .center)
                        Text("Médicos vinculados").font(.system(size: widthMenu == 375 ? 18 : 24)).bold().foregroundColor(.black)
                        
                    }.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: widthMenu == 375 ? 350 : 370, height: 90, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                    
                    
                }
                
            }.padding(.all)
        }
        
    }
}
