//
//  VistaPreguntasFrecuentes.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/19/22.
//

import SwiftUI

struct VistaPreguntasFrecuentes: View {
    var body: some View {
        NavigationView {
            
            VStack (alignment: .leading, spacing: 7) {
                Text("1. ¿Cómo puedo cerrer una sesión?")
                    .fontWeight(.bold)
                Text("Da clic en el butón 'Cerrar sesión'.")
            }
            .navigationTitle("Preguntas frecuentes")
        }
    }
}

struct VistaPreguntasFrecuentes_Previews: PreviewProvider {
    static var previews: some View {
        VistaPreguntasFrecuentes()
    }
}

