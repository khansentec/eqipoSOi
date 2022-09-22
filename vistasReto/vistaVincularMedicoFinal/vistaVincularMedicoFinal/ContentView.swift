//
//  ContentView.swift
//  vistaVincularMedicoFinal
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var cedula: Int = 9235
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Mi medico:").padding(.horizontal)
                }
                Spacer().frame( maxWidth: 400, maxHeight: 50)
                HStack{
                    Text("Nombre de medico:").padding(.horizontal)
                }
                HStack{
                    Image("usuario").resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                    Text("Nombre").padding(.horizontal)
                }
                HStack{
                    Text("Cedúla:")
                    Text(String(cedula))
                }
                Spacer().frame( maxWidth: 400, maxHeight: 150)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
