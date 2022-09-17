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
       
        NavigationLink(destination: VistaPresionArterial(presion1: ""), tag: "Presion", selection: $selection) { EmptyView() }
        NavigationLink(destination: Text("Elija un doctor: "), tag: "Doctor", selection: $selection) { EmptyView() }
        NavigationLink(destination: Text("Vista 3"), tag: "Vista 3", selection: $selection) { EmptyView() }
        
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
                    self.selection = "Doctor"
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
                    self.selection = "Doctor"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                
                Spacer()
                
                Button("Estado de salud") {
                    self.selection = "Doctor"
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
                    self.selection = "Doctor"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
                
                Spacer()
                
                Button("Estadísticas semanales") {
                    self.selection = "Doctor"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
            }
            .padding()

            HStack{
                Button("Médico vinculado") {
                    self.selection = "Doctor"
                }
                .frame(width: 160, height: 100)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(Color.black)
                .clipShape(Rectangle())
            }
            .padding()

        }
        
        Text("Entra una presión arterial para mostrarla aquí: ")
        if (user.presion1 != nil) {
            Text("Presión agregada: \(user.presion1!)")
        }
        
    }
}

struct VistaTablero_Previews: PreviewProvider {
    static var previews: some View {
        VistaTablero()
        PresionImagen()
    }
}



