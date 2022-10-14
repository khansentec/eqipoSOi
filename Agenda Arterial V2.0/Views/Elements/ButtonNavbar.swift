//
//  ButtonNavbar.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

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
    @State private var email = Auth.auth().currentUser?.email
    
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
            Image(systemName: img).foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
            Text(title).font(.system(size:  device == .pad ? 16 : widthMenu == 375 ? 18 : 20)).fontWeight(loginShow.showApp == "Home" ? index == title ? .bold : .none : .none ).foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
        }
    }
}

