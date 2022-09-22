//
//  ContentView.swift
//  vistaAdministrarPerfilDeUsuario
//
//  Created by Alumno on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var nombre: String = ""
    @State var apellidos: String = ""
    @State var correo: String = ""
    @State var sexo: String = ""

    @State var tel: Int = 0
    @State private var date = Date()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("usuario").resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                }
                HStack{
                    Text("Nombre: ").padding(.horizontal)
                    TextField("",text:$nombre).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }
                HStack{
                    Text("Apellidos:").padding(.horizontal)
                    TextField("",text:$apellidos).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Correo:").padding(.horizontal)
                    TextField("",text:$correo).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Sexo:").padding(.horizontal)
                    TextField("",text:$sexo).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Fecha de nacimiento:").padding(.horizontal)
                    DatePicker("",selection: $date,displayedComponents: [.date])
                }
                
                HStack{
                    Text("Numero de teléfono:").padding(.horizontal)
                    TextField("Numero",value: $tel,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
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
