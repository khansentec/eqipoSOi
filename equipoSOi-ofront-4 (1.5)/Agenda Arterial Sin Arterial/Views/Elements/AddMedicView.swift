//
//  AddMedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct AddMedicView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Vincular aquí:").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
            Spacer().frame(maxHeight: 10)
            Text("Por código del paciente:").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
            HStack{
                Text("1").font(.custom("Helvetica", size: 50)).frame(width: 60, height: 60).overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 2)
                )
                .fixedSize()
                Text("2").font(.custom("Helvetica", size: 50)).frame(width: 60, height: 60).overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 2)
                )
                .fixedSize()
                Text("3").font(.custom("Helvetica", size: 50)).frame(width: 60, height: 60).overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 2)
                )
                .fixedSize()
                Text("4").font(.custom("Helvetica", size: 50)).frame(width: 60, height: 60).overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 2)
                )
                .fixedSize()
            }
            
            
            Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
        }
    }
}
