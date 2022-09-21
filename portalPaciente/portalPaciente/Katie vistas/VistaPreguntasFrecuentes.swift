//
//  VistaPreguntasFrecuentes.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/19/22.
//

import SwiftUI

struct VistaPreguntasFrecuentes: View {
    
    @State var listaPreguntas : [[String]]
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                ForEach(listaPreguntas, id: \.self) {
                    pregunta in
                    VStack (alignment: .leading, spacing: 10){
                        Text(pregunta[0])
                            .fontWeight(.bold)
                        Text(pregunta[1])
                    }
                    .padding()
                    Divider()
                }
                
                Spacer()
            }
            .scenePadding()
            .navigationTitle("Preguntas frecuentes")
        }
    }
}

struct VistaPreguntasFrecuentes_Previews: PreviewProvider {
    static var previews: some View {
        
        let ejemplosPreguntas = [
            ["P: ¿Cómo puedo cerrer una sesión?", "R: Da clic en el butón 'Cerrar sesión'."],
            ["P: No tengo un médico vinculado. ¿Cómo puedo conseguir uno?", "R: Naviga a la página de Médico vinculado y da clic en el búton 'Registrar'."]
        ]
        
        VistaPreguntasFrecuentes(listaPreguntas: ejemplosPreguntas)
    }
}

