//
//  VistaEstadoSalud.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct EstadoSalud: View {
    
    @State var descanso : String
    @State var sentimiento : String
    @State var comentarios : String
    @State private var speed = 10.0
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading){
                    Text("Sentimiento del día: ")
                    Slider(
                        value: $speed,
                        in: 0...10
                    )
                    Text("\(Int(speed))")
                }
                .padding()
                
                HStack {
                    Text("Horas de descanso: ")
                    TextField("", value: $descanso, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                HStack {
                    Text("Sentimiento del día: ")
                    TextField("", text: $sentimiento)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                
                VStack (alignment: .leading, spacing: 20) {
                    Text("Síntomas nuevas: ")
                    TextField("", text: $sentimiento)
                        .frame(height: 10.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .scenePadding()
                
                VStack (alignment: .leading, spacing: 20) {
                    Text("Otros comentarios: ")
                    TextField("", text: $comentarios)
                        .frame(height: 10.0)
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

struct EstadoSalud_Previews: PreviewProvider {
    static var previews: some View {
        EstadoSalud(descanso: "", sentimiento: "", comentarios: "")
    }
}
