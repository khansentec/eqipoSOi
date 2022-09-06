//
//  ContentView.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/6/22.
//

import SwiftUI

struct ResultView: View {
    var choice : String
    
    var body: some View {
        Text("You chose \(choice)")
    }
}

struct ContentView: View {
    var body: some View {
        //        Text("Bienvenido")
        //            .fontWeight(.bold)
        //            .font(.largeTitle)
        //            .padding()
        //        Text("al portal de pacientes")
        //            .padding()
        //        Text("Por favor, elija una pagina para abrir.")
        //
        NavigationView {
            VStack(spacing: 30) {
                Text("Por favor, seleccione una página para abrir")
                NavigationLink(destination: Text("Entre una medición para agregar: ")) {
                    Text("Vista 1: Agregar medición")
                }
                NavigationLink(destination: Text("Elija un doctor: ")) {
                    Text("Vista 2: Platicar con doctor vinculado")
                }
            }
            .navigationBarTitle("Navigación")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
