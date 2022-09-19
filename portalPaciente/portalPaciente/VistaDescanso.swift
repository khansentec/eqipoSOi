//
//  VistaDescanso.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/19/22.
//

import SwiftUI

struct VistaDescanso: View {
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                Text("Horas de descanso: ")
            }
            .navigationTitle("Registro de descanso")
        }
    }
}

struct VistaDescanso_Previews: PreviewProvider {
    static var previews: some View {
        VistaDescanso()
    }
}
