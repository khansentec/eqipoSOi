//
//  CreditsView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Katie Hansen on 10/11/22.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 20) {
                Text("Agenda Arterial fue desarrollado como proyecto final de la materia Integración de seguridad informática en redes y sistemas de software en el semestre Ago-Dic 2022.")
                    .bold()
                
                VStack (alignment: .leading, spacing: 5) {
                    Text("Desarrolladores: ")
                    
                    Text("Andrea Corona Arroyo\nWilliam Frank Monroy Mamani\nKatherine Michelle Hansen\nSamuel Jesús Osorio Cortés\nGabriel Crisóstomo Navidad")
                        .padding(.leading, 15)
                }
                
                Text("Créditos del logotipo: rawpixel.com en Freepik")
                
            }
            
            Image("corazon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
            
            Spacer()
        }
        .padding(.all, 30)
    }
}

