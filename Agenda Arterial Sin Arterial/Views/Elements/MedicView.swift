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
        HStack(spacing: 5){
            Image(systemName: "person")
            VStack{
                Text(medic.name+" "+medic.patName).fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
<<<<<<< HEAD
                Text(medic.cedulaProfesional).padding(.leading,20)
=======
                Text(medic.proflicense).padding(.leading,20)
>>>>>>> ofront
                    .lineLimit(1)
            }
            
        }.padding(.vertical,10)
    }
}
