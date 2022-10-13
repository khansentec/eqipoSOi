//
//  MedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentView: View {
    var medicament : Medicament
        
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
                        
                }.frame(width: 300  ,height: 300 )
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(.trailing, 10)
                        .frame(width : 5)
                    Text("Eliminar")
                        .foregroundColor(.red)
                        .padding(.top, 3.5).padding(.all)
                        //.frame(width: 200)
                    
                })
            }.overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
            .padding(.vertical,10) //.border(.black)
        }
}
