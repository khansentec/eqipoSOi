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
            Image(systemName: "person").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
            VStack{
                Text(medic.name+" "+medic.patName).fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                Text(medic.proflicense).padding(.leading,20)
                    .lineLimit(1)
            }
            
        }.padding(.vertical,10)
    }
}
