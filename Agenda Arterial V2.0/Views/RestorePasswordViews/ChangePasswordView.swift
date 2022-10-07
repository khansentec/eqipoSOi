//
//  ChangePasswordView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @State var newPassword = ""
    @State var confNewPassword = ""
    @State var invalidPassword = false
    @State var successfulChange = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        VStack(spacing: 20) {
            Text(
                "Ingresa tu nueva contraseña")
            SecureField("", text: $newPassword).frame(width: 200 )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .keyboardType(.alphabet)
            Text(
                "Vuelve a ingresar tu nueva \ncontraseña").multilineTextAlignment(.center)
            SecureField("", text: $confNewPassword).frame(width: 200 )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .keyboardType(.alphabet)
            Button("Confirmar") {
                if (newPassword != "" || confNewPassword != "") && newPassword == confNewPassword{
                    print(newPassword)
                    successfulChange = true
                }else{
                    invalidPassword = true
                }
            }.alert("Error", isPresented: $invalidPassword ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                if newPassword != confNewPassword{
                    Text("Las contraseñas deben coincidir")
                }else{
                    Text("Ingresa una contraseña valida")
                }
                
            }.alert("Cambio Exitoso", isPresented: $successfulChange ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                Text("Su contraseña ha sido cambiada exitosamente")
            }
            
            
        }
        
    }
}

