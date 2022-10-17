//
//  RestorePasswordView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 17/10/22.
//

import SwiftUI

struct RestorePasswordView: View {
        @State var correoStr = ""
        @State var showAlert = false
        @State private var alertTittle = ""
        @State private var alertMessage = ""
        @State private var sended = false
        
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
                        TextField("", text: $correoStr).frame(width: 200 )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .fixedSize()
                            .keyboardType(.alphabet)
                        Button("Enviar") {
                            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                            
                            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                            
                            if emailPred.evaluate(with: correoStr){
                                print(correoStr)
                                login.sendPasswordReset(withEmail: correoStr){
                                    (done)in
                                    if done{
                                        showAlert = true
                                        sended = true
                                        alertTittle = "¡Exito!"
                                        alertMessage = "Correo para restaurar contraseña enviado"
                                    }else{
                                        showAlert = true
                                        alertTittle = "¡Opps!"
                                        alertMessage = "Este correo no esta registrado"
                                    }
                                }
                            }else{
                                showAlert = true
                            }
                        }.alert(alertTittle, isPresented: $showAlert ){
                            Button("OK"){
                                if sended{
                                    loginShow.show = "Login"
                                }
                            }
                        } message: {
                            Text(alertMessage)
                        }
                        
                        
                    }
                    
                    Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
                }
                
            }
        }
}
