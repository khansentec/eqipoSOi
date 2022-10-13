//
//  MedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentView: View {
    var medicament : Medicament
    @StateObject var login = FirebaseViewController()
    
    var body: some View{
        HStack{
            VStack(alignment:.leading, spacing : 5){
                Text(medicament.medicamentName)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(.blue)
                Text(medicament.information)
                    .padding(.leading,20)
                    .lineLimit(1)
                
            }
        }
        .padding(.vertical,10).border(.black)
    }
}
