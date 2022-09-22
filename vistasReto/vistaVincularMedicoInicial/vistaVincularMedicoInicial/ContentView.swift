//
//  ContentView.swift
//  vistaVincularMedicoInicial
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("No hay Medico Vinculado").padding().frame(maxWidth:400,alignment: .center)
                }
                HStack{
                    Button("Vincular"){
                        
                    }
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
