//
//  ButtonNavbar.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
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
                loginShow.show = whereto
                
            }
        }){
            Image(systemName: img).foregroundColor(index == title ? .black : Color.blue.opacity(0.6))
            Text(title).font(.system(size: widthMenu == 375 ? 18 : 20)).fontWeight(index == title ? .bold : .none).foregroundColor(index == title ? .black : Color.blue.opacity(0.6))
        }
    }
}

