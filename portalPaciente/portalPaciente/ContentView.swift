//
//  ContentView.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Bienvenido")
            .fontWeight(.bold)
            .font(.largeTitle)
            .padding()
        Text("al portal de pacientes")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
