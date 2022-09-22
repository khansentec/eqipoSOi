//
//  ContentView.swift
//  vistSesión
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var usuario: String = ""
    @State var contraseña: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                Text("Agenda Arterial").padding()
                HStack{
                    Text("Usuario:").padding(.horizontal)
                }
                HStack{
                    TextField("",text: $usuario).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                }
                
                HStack{
                    Text("Contraseña:").padding(.horizontal)
                }
                HStack{
                    TextField("",text: $contraseña).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                }
                Button("Iniciar"){
                    
                }
                Spacer().frame(maxWidth: 400, minHeight: 100)
                
                HStack{
                    Text("Políticas").foregroundColor(.accentColor)
                    Text("Olividé Contraseña").frame(maxWidth: .infinity ,alignment: .trailing)
                    Text("Registrarse").frame(maxWidth: .infinity ,alignment: .trailing)

                    
                }
            }
        }
    }
}


