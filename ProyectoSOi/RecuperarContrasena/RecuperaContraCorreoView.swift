//
//  CorreoView.swift
//  ProyectoSOi
//
//  Created by alumno on 19/09/22.
//

import SwiftUI

struct RecuperaContraCorreoView: View {
    @State var correoStr = ""
    @State var correoInvalido = false
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
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
                    
                }else{
                    correoInvalido = true
                }
            }.alert("Error", isPresented: $correoInvalido ){
                Button("OK"){
                    //si se oprime quitar el ok
                }
            } message: {
                Text("Ingresa un correo valido")
            }
            
            
        }
        
    }
}

