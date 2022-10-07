//
//  NavBarHome.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct NavBarHome: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var menu : Bool
    @Binding var index : String
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    
    var body: some View {
        
        HStack{
            
            if device == .pad{
                Spacer()
                Text("Agenda Arterial")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal")
                ButtonNavbar(index: $index, menu: $menu,whereto: "SettingsView", img: "gearshape.fill", title: "Configuración").frame(width: 155)
                ButtonNavbar(index: $index, menu: $menu,whereto: "GeneralDataView", img: "person.crop.circle", title: "Datos Generales")
                ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes")
                Button(action: {
                    loginShow.show = "Login"
                }){
                    Text("Sign Out").font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }.padding(.all)
                Spacer()
            }else{
                
                Button(action: {
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3").font(.system(size: 26))
                        .foregroundColor(.white)
                }
            
            Spacer().frame(minWidth: 10, maxWidth: 20)
            Text("Agenda Arterial")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
                Spacer()
            }
            
        }.padding(.top, device == .pad ? 0: widthMenu == 375 ? 20 : 40)
            .padding()
            .background(Color("ButtonColor"))
        
    }
}

