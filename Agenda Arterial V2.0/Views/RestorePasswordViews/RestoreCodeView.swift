//
//  RestoreCodeView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct RestoreCodeView: View {
    @State var digit1 = ""
    @State var digit2 = ""
    @State var digit3 = ""
    @State var digit4 = ""
    @State var digit5 = ""
    @State var digit6 = ""
    @State var codeStr = ""
    @State var originalCode = 123456
    
    @State var invalidCode = false
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    @State private var widthMenu = UIScreen.main.bounds.width
    
    var body: some View {
        NavbarLogin(title: "Ingresa Tu Correo", whereTo: "RestorePasswordView")
        Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
        VStack(spacing: 20) {
            Text(
                "Ingresa el codigo")
            HStack{
                TextField("", text: $digit1).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digit2).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digit3).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digit4).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                
                TextField("", text: $digit5).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                
                TextField("", text: $digit6).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
            }
            
            Button("Validar") {
                codeStr = digit1 + digit2 + digit3 + digit4 + digit5 + digit6
                if let codigo = Int(codeStr){
                    if originalCode == codigo{
                        print(codigo)
                        print("Codigo valido")
                        withAnimation{
                            loginShow.show = "ChangePasswordView"
                        }
                    }else{
                        invalidCode = true
                        
                    }
                }else{
                    invalidCode = true
                }
            }.alert("Error", isPresented: $invalidCode ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                Text("Ingresa un codigo valido")
            }
            
            Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
        }
        
    }
}
