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
                Text(medic.name+" " + medic.patName)
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(Color("ButtonColor"))
                    .padding(.bottom, 5)
                Text(medic.proflicense)
                    .lineLimit(1)
                Link(medic.phone, destination: URL(string: "tel:" + medic.phone)!)
            }
        }
        .padding(.vertical,10)
    }
}
