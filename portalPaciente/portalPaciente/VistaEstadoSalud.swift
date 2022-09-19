//
//  VistaEstadoSalud.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaEstadoSalud: View {
    
    @State var descanso : String
    @State var sentimiento : String
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                HStack {
                    Text("Horas de descanso: ")
                    TextField("", text: $descanso)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                HStack {
                    Text("Sentimiento del día: ")
                    TextField("", text: $sentimiento)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                HStack {
                    Text("Síntomas nuevas: ")
                    TextField("", text: $sentimiento)
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
        VistaEstadoSalud(descanso: "", sentimiento: "")
    }
}

