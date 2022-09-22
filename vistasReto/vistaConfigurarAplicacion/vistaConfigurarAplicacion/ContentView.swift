//
//  ContentView.swift
//  vistaConfigurarAplicacion
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var iOn = true
    @State private var iOff = false

    var body: some View {
        ZStack{
            VStack{
                Text("Notificaciónes")
                HStack{
                    Toggle("Consultas",isOn: $iOn)
                }
                HStack{
                    Toggle("Mediciones",isOn: $iOn)
                }
                HStack{
                    Toggle("Notificaciónes por correo",isOn: $iOff)
                }
                Spacer()
                HStack{
                    Text("Políticas").foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
