//
//  RestorePasswordView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct RestorePasswordView: View {
    @State var emailStr = ""
    @State var invalidEmail = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(){
                NavbarLogin(title: "Iniciar Sesion", whereTo: "Login")
                Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
                VStack(spacing: 20) {
                    Text(
                        "Ingresa tu correo")
                    TextField("", text: $emailStr).frame(width: 200 )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .fixedSize()
                        .keyboardType(.alphabet)
                    Button("Enviar") {
                        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                        
                        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                        
                        if emailPred.evaluate(with: emailStr){
                            print(emailStr)
                            withAnimation{
                                loginShow.show = "RestoreCodeView"
                            }
                        }else{
                            invalidEmail = true
                        }
                    }.alert("Error", isPresented: $invalidEmail ){
                        Button("OK"){
                            //si se oprime quitar el ok
                        }
                    } message: {
                        Text("Ingresa un correo valido")
                    }
                    
                    
                }
                
                Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
            }
            
        }
    }
}
