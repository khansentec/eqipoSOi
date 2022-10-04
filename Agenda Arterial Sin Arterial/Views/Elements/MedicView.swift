//
//  MedicView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct MedicView: View {
    
    var medic : Medic
    
    var body: some View {
        HStack(spacing: 5){
            Image(systemName: "person")
            VStack{
                Text(medic.nombre+" "+medic.apellidoPaterno).fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                Text(medic.cedulaProfesional).padding(.leading,20)
                    .lineLimit(1)
            }
            
        }.padding(.vertical,10)
    }
}
