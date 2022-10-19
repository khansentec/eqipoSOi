//
//  MedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicView: View {
    var medic : Medic
    
    var body: some View {
        HStack(spacing: 30){
            
            Image(systemName: "person")
            
            VStack (alignment: .leading){
                Text(medic.name + " " + medic.patName+" " + medic.matName)
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(Color("ButtonColor"))
                    .padding(.bottom, 2)
                Text("Cédula profesional: " + medic.proflicense)
                    .lineLimit(1).padding(.bottom, 2)
                if medic.phone != "no phone"{
                    HStack (spacing: 0){
                        Text("Número de teléfono: ")
                        Link("+\(medic.phone)", destination: URL(string: "tel:" + medic.phone)!)
                    }
                }
            }
            
            Spacer()
        }
        .aspectRatio(contentMode: .fill)
        .padding(.vertical,10)
    }
}
