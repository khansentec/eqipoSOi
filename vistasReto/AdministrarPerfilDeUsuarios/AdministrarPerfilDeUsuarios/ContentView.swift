//
//  ContentView.swift
//  AdministrarPerfilDeUsuarios
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var altura: Float = 0.0
    @State var peso: Float = 0.0
    @State var padecimiento: String = ""
    @State var alergias: String = ""
    @State var tipoSangre: String = ""
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Datos Personales:").padding(.horizontal).frame(alignment:.center)
                }
                HStack{
                    Text("Todas son opcionales").frame(alignment: .leading).padding().foregroundColor(.red)
                }
                HStack{
                    Text("Altura:").padding(.horizontal)
                    TextField("Altura",value: $altura,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Peso:").padding(.horizontal)
                    TextField("Peso",value: $peso,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Padecimientos Medicos:").padding(.horizontal)
                    TextField("",text: $padecimiento).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Alergias:").padding(.horizontal)
                    TextField("",text: $alergias).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Tipo de sangre:").padding(.horizontal)
                    TextField("",text:$tipoSangre).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Button("Guardar"){
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
