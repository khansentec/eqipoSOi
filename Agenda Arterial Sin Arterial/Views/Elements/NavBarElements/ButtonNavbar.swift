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
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/Elements/NavBarElements/ButtonNavbar.swift
            index = title
            if device == .phone{
                menu.toggle()
=======
            withAnimation{
                index = title
                if device == .phone{
                    menu.toggle()
                }
                
                loginShow.showApp = "Home"
                loginShow.show = whereto
                
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/Elements/ButtonNavbar.swift
            }
            loginShow.show = whereto
        }){
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/Elements/NavBarElements/ButtonNavbar.swift
            HStack (alignment: .top, spacing: 10){
                Image(systemName: img)
                    .foregroundColor(index == title ? .black : Color("ButtonColor").opacity(0.6))
                    .padding(3)
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: widthMenu == 375 ? 18 : 20))
                    .fontWeight(index == title ? .bold : .none)
                    .foregroundColor(index == title ? .black : Color("ButtonColor").opacity(0.6))
            }
=======
            Image(systemName: img).foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
            Text(title).font(.system(size:  device == .pad ? 16 : widthMenu == 375 ? 18 : 20)).fontWeight(loginShow.showApp == "Home" ? index == title ? .bold : .none : .none ).foregroundColor(loginShow.showApp == "Home" ? index == title ? .black : device == .pad ? Color.white : Color.blue.opacity(0.6) : device == .pad ? Color.white : Color.blue.opacity(0.6))
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/Elements/ButtonNavbar.swift
        }
    }
}

