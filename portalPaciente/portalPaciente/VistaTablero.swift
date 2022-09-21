//
//  VistaTablero.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaTablero: View {
    
    @State private var selection: String? = nil
    @StateObject var user = User()

    var body: some View {
       
//        NavigationLink(destination: VistaPresionArterial(presion1: ""), tag: "Presion", selection: $selection) { }
//        NavigationLink(destination: VistaHabitos(), tag: "Habitos", selection: $selection) { }
//        NavigationLink(destination: VistaMedicamentos(), tag: "Vista 3", selection: $selection) { }
//        NavigationLink(destination: VistaEstadoSalud(descanso: "", sentimiento: "", comentarios: ""), tag: "Estado", selection: $selection) { }
//        NavigationLink(destination: VistaCalendario(), tag: "Calendario", selection: $selection) { }
//        NavigationLink(destination: VistaEstadisticas(), tag: "Estadisticas", selection: $selection) { }
//        NavigationLink(destination: VistaMedico(), tag: "Medico", selection: $selection) { }
        
        VStack {
            HStack {
                Button("Presión arterial") {
                    self.selection = "Presion"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                .shadow(radius: 15)
                
                Spacer()
                
                Button("Habitos saludables") {
                    self.selection = "Habitos"
                }
                .frame(width: 160, height: 100)
//                        .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                .shadow(radius: 15)

            }
            .padding()
            
            HStack{
                Button("Medicamentos") {
                    self.selection = "Medicamentos"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                
                Spacer()
                
                Button("Estado de salud") {
                    self.selection = "Estado"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
            }
            .padding()

            
            HStack{
                Button("Calendario") {
                    self.selection = "Calendario"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                
                Spacer()
                
                Button("Estadísticas semanales") {
                    self.selection = "Estadisticas"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
            }
            .padding()

            HStack {
                Button("Médico vinculado") {
                    self.selection = "Medico"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
            }
            .padding()

            Text("Entra una presión arterial para mostrarla aquí: ")
            if (user.presion1 != nil) {
                Text("Presión agregada: \(user.presion1!)")
            }
        }
        
    }
}

struct VistaTablero_Previews: PreviewProvider {
    static var previews: some View {
        VistaTablero()
    }
}

