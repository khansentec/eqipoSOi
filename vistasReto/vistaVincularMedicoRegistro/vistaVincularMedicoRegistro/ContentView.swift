//
//  ContentView.swift
//  vistaVincularMedicoRegistro
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var clave: Int = 43252
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    Text("Por código:")
                }
                Spacer().frame(maxWidth: 400,maxHeight: 20)
                HStack{
                    Text(String(clave))
                }
                Spacer().frame(maxWidth: 400,maxHeight: 100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
