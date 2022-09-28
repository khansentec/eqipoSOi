//
//  FrecuentlyAskedCuestionsView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct FrecuentlyAskedCuestionsView: View {
    @State var listaPreguntas = [[String]]()
    @State private var index = "Preguntas Frecuentes"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
       var body: some View {
           
           ZStack(alignment: .leading){
               VStack{
                   NavBarHome(menu:$menu).onTapGesture {
                       withAnimation{
                           menu = false
                       }
                   }
                   Text("Preguntas Frecuentes").bold().font(.title)
                       VStack (alignment: .leading) {
                           
                           ForEach(listaPreguntas, id: \.self) {
                               pregunta in
                               VStack (alignment: .leading, spacing: 10){
                                   Text(pregunta[0])
                                       .fontWeight(.bold)
                                   Text(pregunta[1])
                               }
                               .padding()
                               Divider()
                           }
                           
                           Spacer()
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
                                   Text("Preguntas Frecuentes").foregroundColor(.blue).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
                               }
                               Spacer()
                           }.padding()
                               .padding(.top, 50)
                           VStack(alignment: .leading){
                               ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                               ButtonNavbar(index: $index, menu: $menu,whereto: "GDV", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                               ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                               ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 25 : 32)
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
