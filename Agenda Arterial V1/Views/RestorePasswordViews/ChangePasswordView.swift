//
//  ChangePasswordView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @State var contraNueva = ""
    @State var confContraNueva = ""
    @State var contraInvalida = false
    @State var cambioExitoso = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        VStack(spacing: 20) {
            Text(
                "Ingresa tu nueva contraseña")
            SecureField("", text: $contraNueva).frame(width: 200 )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .keyboardType(.alphabet)
            Text(
                "Vuelve a ingresar tu nueva \ncontraseña").multilineTextAlignment(.center)
            SecureField("", text: $confContraNueva).frame(width: 200 )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .keyboardType(.alphabet)
            Button("Confirmar") {
                if (contraNueva != "" || confContraNueva != "") && contraNueva == confContraNueva{
                    print(contraNueva)
                    cambioExitoso = true
                }else{
                    contraInvalida = true
                }
            }.alert("Error", isPresented: $contraInvalida ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                if contraNueva != confContraNueva{
                    Text("Las contraseñas deben coincidir")
                }else{
                    Text("Ingresa una contraseña valida")
                }
                
            }.alert("Cambio Exitoso", isPresented: $cambioExitoso ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                Text("Su contraseña ha sido cambiada exitosamente")
            }
            
            
        }
        
    }
}
