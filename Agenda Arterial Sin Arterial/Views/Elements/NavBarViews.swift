//
//  NavBarViews.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import SwiftUI

struct NavBarViews: View {
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        
        HStack{
            
            if device == .pad{
                
            }else{
                
                Button(action: {
                    withAnimation{
                        loginShow.show = "Home"
                    }
                }){
                    Image(systemName: "arrow.left")
                        .font(.system(size:  widthMenu == 375 ? 18 : 19)).foregroundColor(.white)
                        .foregroundColor(.white)
                    Text("Menu Principal").foregroundColor(.white).font(.system(size: widthMenu == 375 ? 16 : 18))
                }
            }
            Spacer()
        }
        .padding(.top, widthMenu == 375 ? 20 : 35).padding().background(Color("ButtonColor"))
        
    }
}

