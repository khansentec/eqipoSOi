//
//  NavBarHome.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import SwiftUI

struct NavBarHome: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var menu : Bool
    @State private var widthMenu = UIScreen.main.bounds.width
    
    var body: some View {
        
        HStack{
            if device == .pad {
                
            } else {
                
                Button(action: {
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3").font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
            Spacer().frame(minWidth: 10, maxWidth: 20)
            Text("Agenda Arterial")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
        }
        .padding(.top, widthMenu == 375 ? 20 : 40).padding().background(Color("ButtonColor"))
        
    }
}


