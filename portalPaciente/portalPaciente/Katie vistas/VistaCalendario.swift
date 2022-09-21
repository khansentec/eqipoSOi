//
//  VistaCalendario.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

class Recordatorio : Codable {
    var id = UUID()
    var fecha : String
    var eventos : [String]
    
    init(fecha : String, eventos: [String]) {
        self.fecha = fecha
        self.eventos = eventos
    }
}

struct VistaCalendario: View {
    
    // Lista de recordatorios heredada de la llamada a VistaCalendario
    @State var listaRecordatorios : [Recordatorio]
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                if listaRecordatorios.count == 0 {
                    Text("Hi")
                } else {
                    
                    HStack (alignment: .top) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            Text("Recordatorios: ")
                                .font(.title)
                            
                            ForEach(listaRecordatorios, id: \.id) {
                                recordatorio in
                                
                                VStack (alignment: .center, spacing: 10) {
                                    Text(recordatorio.fecha)
                                        .fontWeight(.bold)
                                    VStack {
                                        ForEach(recordatorio.eventos, id: \.self) {
                                            evento in
                                            HStack {
                                                Text(evento)
                                            }
                                        }
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(width: 250)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.blue).shadow(radius: 3))
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .scenePadding()
                    
                    Spacer()
                }
            }
            .navigationTitle("Calendario")
        }
    }
}

struct ContentView2: View {
    let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        VStack {
            ForEach(colors, id: \.self) { color in
                Text(color.description.capitalized)
                    .padding()
                    .background(color)
            }
        }
    }
}

struct VistaCalendario_Previews: PreviewProvider {
    static var previews: some View {
        
        var ejemploRecordatorios = [
            Recordatorio(fecha: "28/2/19", eventos: ["Próxima cita"]),
            Recordatorio(fecha: "29/2/19", eventos: ["Próxima medición", "Próxima toma de presión"])
        ]
        
        VistaCalendario(listaRecordatorios: ejemploRecordatorios)
        ContentView2()
    }
}

