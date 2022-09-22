//
//  ContentView.swift
//  vistaRegistrarse
//
//  Created by Alumno on 19/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var nombre: String = ""
    @State var correo: String = ""
    @State var contraseña: String = ""
    @State var confirmarCont: String = ""
    @State var sexo: String = ""
    @State private var date = Date()
    @State private var numero = 0
    
    var body: some View {
        ZStack{
            
            VStack{
                Text("Registro").fontWeight(.bold).padding(.horizontal).padding(.vertical)
                HStack{
                    Text("Nombre").fontWeight(.bold)
                    TextField("",text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }
                HStack{
                    Text("Correo Electronico").fontWeight(.bold)
                    TextField("",text: $correo).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Contraseña").fontWeight(.bold)
                    TextField("",text: $contraseña).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }
                HStack{
                    Text("Confirmar Contraseña").fontWeight(.bold)
                    TextField("",text: $confirmarCont).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                }
                HStack{
                    Text("Sexo").fontWeight(.bold)
                    TextField("",text: $sexo).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }
                HStack{
                    Text("Fecha de Nacimiento").fontWeight(.bold)
                    DatePicker("",selection: $date,displayedComponents: [.date])
                }
                HStack{
                    Text("Numero de Celular").fontWeight(.bold)
                    TextField("Numero",value: $numero,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }
                Spacer().frame( maxWidth: 400, minHeight: 100)
            }

        }.background(Color.blue)
    }
    
}
