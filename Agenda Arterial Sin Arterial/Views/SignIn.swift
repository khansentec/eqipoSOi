//
//  SignIn.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct SignIn: View {
    @State var nombre: String = ""
    @State var email: String = ""
    @State var pass: String = ""
    @State var confirmarCont: String = ""
    @State var sexo: String = ""
    enum sex: String, CaseIterable, Identifiable {
        case nonseleceted, male, female, rathernot
        var id: Self { self }
    }
    @State private var selectedSex: sex = .nonseleceted
    @State private var date = Date()
    @State private var numero = 0
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var progress = false
    
    var body: some View {
        ZStack{
            VStack{
                NavbarLogin(title: "Iniciar Sesion", whereTo: "Login")
                VStack{
                    Text("Registro").fontWeight(.bold).padding(.horizontal).padding(.vertical).font(.title)
                    HStack{
                        Text("Nombre").fontWeight(.bold)
                        TextField("Nombre",text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                        
                    }
                    HStack{
                        Text("Correo Electronico").fontWeight(.bold)
                        TextField("Correo",text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    }
                    HStack{
                        Text("Contraseña").fontWeight(.bold)
                        SecureField("",text: $pass).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                        
                    }
                    HStack{
                        Text("Confirmar Contraseña").fontWeight(.bold)
                        SecureField("",text: $confirmarCont).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    }
                    HStack{
                        Text("Sexo").fontWeight(.bold)
                        Picker("", selection: $selectedSex) {
                            Text("Selecione una opcion").tag(sex.nonseleceted)
                            Text("Hombre").tag(sex.male)
                            Text("Mujer").tag(sex.female)
                            Text("Prefiero no decir").tag(sex.rathernot)
                        }.frame(width : 200, height: 20)
                            .accentColor(.blue)
                        
                    }
                    HStack{
                        Text("Fecha de Nacimiento").fontWeight(.bold)
                        DatePicker("",selection: $date,displayedComponents: [.date])
                    }
                    HStack{
                        Text("Numero de Celular").fontWeight(.bold)
                        TextField("Numero",value: $numero,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                        
                    }.padding(.bottom, 20)
                    //                    Spacer().frame(minHeight: 50, maxHeight: 100)
                    Button(action: {
                        progress = true
                        loginShow.show = "Home"
                        
                    }){
                        Text("Iniciar").font(.system( size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.background(
                        Capsule().fill(Color("ButtonColor"))
                    ).alert(errorMessage, isPresented: $showError) {
                        Button("OK", role: .cancel) {
                            progress = false
                        }
                    }
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black)
                        ProgressView()
                    }
                    
                }.padding(.all)
                Spacer()
            }
            
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

