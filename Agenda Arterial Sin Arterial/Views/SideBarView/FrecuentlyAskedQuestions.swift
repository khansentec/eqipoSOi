//
//  FrecuentlyAskedQuestions.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
struct FrecuentlyAskedQuestions: View {
    @State var questionList = [[String]]()
    @State private var index = "Preguntas Frecuentes"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    var body: some View {
        
        ZStack(alignment: .leading){
            VStack{
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/FrecuentlyAskedCuestionsView.swift
                NavBarHome(menu:$menu).onTapGesture {
=======
                NavBarHome(menu:$menu, index: $index).onTapGesture {
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/FrecuentlyAskedQuestions.swift
                    withAnimation{
                        menu = false
                    }
                }
                Text("Preguntas Frecuentes").bold().font(.title)
                VStack (alignment: .leading) {
                    
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/FrecuentlyAskedCuestionsView.swift
                    ForEach(listaPreguntas, id: \.self) {
=======
                    ForEach(questionList, id: \.self) {
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/FrecuentlyAskedQuestions.swift
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
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/FrecuentlyAskedCuestionsView.swift
                menu = false
            }
            if menu{
                NavBarMenu(index: "Preguntas Frecuentes", menu: false)
=======
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
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 25 : 32).padding(.bottom,10)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "SettingsView", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 16)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "GeneralDataView", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.leading,widthMenu == 375 ? 15 : 21)
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
                
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/FrecuentlyAskedQuestions.swift
            }
        }
    }
}

