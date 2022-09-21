//
//  RestoreCodeView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct RestoreCodeView: View {
    @State var digito1 = ""
    @State var digito2 = ""
    @State var digito3 = ""
    @State var digito4 = ""
    @State var digito5 = ""
    @State var digito6 = ""
    @State var codigoStr = ""
    @State var codigoOriginal = 123456
    
    @State var codigoInvalido = false
    
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
                TextField("", text: $digito1).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digito2).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digito3).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                TextField("", text: $digito4).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                
                TextField("", text: $digito5).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
                
                TextField("", text: $digito6).frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize()
                    .keyboardType(.numberPad)
            }
            
            Button("Validar") {
                codigoStr = digito1 + digito2 + digito3 + digito4 + digito5 + digito6
                if let codigo = Int(codigoStr){
                    if codigoOriginal == codigo{
                        print(codigo)
                        print("Codigo valido")
                        withAnimation{
                            loginShow.show = "ChangePasswordView"
                        }
                    }else{
                        codigoInvalido = true
                        
                    }
                }else{
                    codigoInvalido = true
                }
            }.alert("Error", isPresented: $codigoInvalido ){
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

