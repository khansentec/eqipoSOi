//
//  MedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentView: View {
    
    @State private var screenWidth = UIScreen.main.bounds.width
    
    var medicament : Medicament
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                VStack(alignment:.leading, spacing: 5) {
                    Text(medicament.medicamentName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                        .foregroundColor(Color("ButtonColor"))
                    Text(medicament.information)
                        .lineLimit(1)
                }
                
                Spacer(minLength: 10)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(.trailing, 5)
                        .frame(width : 5)
                    Text("Eliminar")
                        .foregroundColor(.red)
                        .padding(.top, 3.5)
                })
                
            }
            .frame(minWidth: screenWidth-100, minHeight: 70)
            .padding(10)
            
            Spacer()
        }
        .aspectRatio(contentMode: .fit)
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: screenWidth-50, minHeight: 70)
        .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)).shadow(radius: 3))
        
    }
}
