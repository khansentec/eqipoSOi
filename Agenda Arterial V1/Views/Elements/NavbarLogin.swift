//
//  NavbarLogin.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct NavbarLogin: View {
    var device = UIDevice.current.userInterfaceIdiom
    @State var title : String
    @State var whereTo : String
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        
        HStack{
            
            if device == .pad{
                
            }else{
                
                Button(action: {
                    withAnimation{
                        loginShow.show = whereTo
                    }
                }){
                    Image(systemName: "arrow.left")
                        .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(.white)
                        .foregroundColor(.white)
                    Text(title).foregroundColor(.white).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
                }
            }
            Spacer()
        }.padding(.top, widthMenu == 375 ? 20 : 40).padding().background(Color.blue)
        
    }
}
