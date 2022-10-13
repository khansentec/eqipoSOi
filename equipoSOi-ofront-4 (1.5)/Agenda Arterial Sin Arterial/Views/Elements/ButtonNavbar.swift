//
//  ButtonNavbar.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct ButtonNavbar: View {
    @Binding var index : String
    @Binding var menu : Bool
    @State var whereto  = ""
    @State var img : String
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    var title : String
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        Button(action:{
            withAnimation{
                index = title
                if device == .phone{
                    menu.toggle()
                }
                
                loginShow.showApp = "Home"
                loginShow.show = whereto
                
            }
        }){
            Image(systemName: img).resizable().aspectRatio(contentMode: .fit)
                //.frame(width: 30, height: 30)
                //.frame(width: widthMenu == 1024 ? 30 : 15 , height: widthMenu == 1024 ? 30: 15)
                .frame(width: widthMenu == 1024 ? 30 : 18 , height: widthMenu == 1024 ? 30: 18)
                .foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
            
            Text(title)
                //.font(.system(size:  device == .pad ? 26 : widthMenu == 375 ? 18 : 20))
                //.font(.system(size: device == .pad ? widthMenu == 1024 ? 26 : 24 :widthMenu == 375 ? 18 : 20))
                .font(.system(size: device == .pad ? widthMenu == 1024 ? 26 : 20 :widthMenu == 375 ? 18 : 20))
                .fontWeight(loginShow.showApp == "Home" ? index == title ? .bold : .none : .none ).foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
        }
    }
}

