//
//  NavBarContents.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Katie Hansen on 10/6/22.
//

import SwiftUI
import Firebase

struct NavBarMenu: View {
    
    @Binding var index : String
    @Binding var menu : Bool
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading){
                HStack {
                    Button(action: {
                        menu.toggle()
                    }){
                        HStack (alignment: .top){
                            Image(systemName: "arrow.left")
                                .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(Color("ButtonColor"))
                                .foregroundColor(.white)
                                .padding(3)
                            Text(index)
                                .foregroundColor(Color("ButtonColor"))
                                .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold))
                        }
                        .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .padding(.top, 50)
                
                VStack(alignment: .leading, spacing: 20){
                    ButtonNavbar(index: $index, menu: $menu, whereto: "Home", img: "house", title: "Menu Principal")
                        .padding(.leading,widthMenu == 375 ? 15 : 21)
                    ButtonNavbar(index: $index, menu: $menu, whereto: "GeneralDataView", img: "person.crop.circle", title: "Datos Generales")
                        .padding(.leading,widthMenu == 375 ? 15 : 21)
                    ButtonNavbar(index: $index, menu: $menu, whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes")
                        .padding(.leading,widthMenu == 375 ? 15 : 21)
                    ButtonNavbar(index: $index, menu: $menu, whereto: "SettingsView", img: "gearshape.fill", title: "Configuración")
                        .padding(.leading,widthMenu == 375 ? 15 : 21)
                    
                    Spacer()
                    
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.data = nil
                        loginShow.reminds = []
                        loginShow.medics = []
                        loginShow.meds = []
                        loginShow.medUpdate = nil
                        loginShow.remindUpdate = nil
                        loginShow.show = "Login"
                    }){
                        Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(Color("ButtonColor"))
                    }
                    .padding(30)
                }
                .multilineTextAlignment(.leading)
                .padding(.trailing, 20)
                
                Spacer()
                
            }
            .frame(width: widthMenu-150)
            .background(Color("BlueBBVA"))
            .padding(.trailing, 30)
        }
    }
}
