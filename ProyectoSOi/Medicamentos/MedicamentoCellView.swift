//
//  MedicamentoCellView.swift
//  ProyectoSOi
//
//  Created by alumno on 19/09/22.
//

import SwiftUI

struct MedicamentoCell :View {
    var medicamento : Medicamento
    
    var body: some View{
        VStack(alignment:.leading, spacing : 5){
            Text(medicamento.nombreMedicamento)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.9).foregroundColor(.blue)
            Text(medicamento.informacion)
                .padding(.leading,20)
                .lineLimit(1)
                
        }.padding(.vertical,10)
    }
}


