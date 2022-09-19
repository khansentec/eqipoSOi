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
    
    var device = UIDevice.current.userInterfaceIdiom
    var title : String
    
    var body: some View {
        Button(action:{
            withAnimation{
                index = title
                if device == .phone{
                    menu.toggle()
                }
            }
        }){
            Text(title).font(.title).fontWeight(index == title ? .bold : .none).foregroundColor(index == title ? .white : Color.blue.opacity(0.6))
        }
    }
}

