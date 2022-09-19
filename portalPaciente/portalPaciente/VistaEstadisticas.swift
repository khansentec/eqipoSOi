//
//  VistaEstadisticas.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaEstadisticas: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Se muestra la estadísticas semanales aquí.")
                    .font(.title)
                    .padding()
                Text("Usando la estructura Swift Charts")
            }
        }
    }
}

struct VistaEstadisticas_Previews: PreviewProvider {
    static var previews: some View {
        VistaEstadisticas()
    }
}
