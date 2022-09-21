//
//  VistaEstadoSalud.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaEstadoSalud: View {
    
    @State var descanso : String
    @State var sentimiento_med : Float
    @State var sintomas : String
    
    var body: some View {

        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("¿Cómo has sentido con el medicamento?")
                Slider(
                    value: $sentimiento_med,
                    in: 0...10
//                    onEditingChanged: { editing in
//                        isEditing = editing
//                    }
                )
                Text("\(Int(sentimiento_med))")
                    .frame(alignment: .center)
                
                HStack {
                    Text("Horas de descanso: ")
                    TextField("", text: $descanso)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                
                HStack {
                    Text("Síntomas nuevas: ")
                    TextField("", text: $sintomas)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                
                Spacer()
            }
            .scenePadding()
            .navigationTitle("Estado de salud")
            
        }
    }
}

struct VistaEstadoSalud_Previews: PreviewProvider {
    static var previews: some View {
        VistaEstadoSalud(descanso: "", sentimiento_med: 0, sintomas: "")
    }
}

