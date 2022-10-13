//
//  SignIn.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct SignIn: View {
    @State var name: String = ""
    @State var patName : String = ""
    @State var matName : String = ""
    @State var email: String = ""
    @State var pass: String = ""
    @State var confPassword: String = ""
    enum sex: String, CaseIterable, Identifiable {
        case nonseleceted, male, female, rathernot
        var id: Self { self }
    }
    @State private var selectedSex: sex = .nonseleceted
    @State private var date = Date()
    @State private var number = 0
    
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var progress = false
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        
        ZStack{
            VStack{
                NavbarLogin(title: "Iniciar Sesion", whereTo: "Login")
                Text("Registro").padding(.horizontal).padding(.vertical).font(.title).bold()
                VStack{
                    VStack{
                        HStack{
                            Text("Nombre").fontWeight(.bold)
                            TextField("Nombre",text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                            
                        }
                        HStack{
                            Text("Apellido Paterno").fontWeight(.bold)
                            TextField("Apellido Paterno",text: $patName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                            
                        }
                        HStack{
                            Text("Apellido Materno").fontWeight(.bold)
                            TextField("Apellido Materno",text: $matName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                            
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
                            SecureField("",text: $confPassword).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                        }
                        HStack{
                            Text("Sexo").fontWeight(.bold)
                            Picker("", selection: $selectedSex) {
                                Text("Selecione una opcion").tag(sex.nonseleceted)
                                Text("Hombre").tag(sex.male)
                                Text("Mujer").tag(sex.female)
                                Text("Prefiero no decir").tag(sex.rathernot)
                            }.frame(width : 200, height: 20)
                                .accentColor(Color("ButtonColor"))
                            
                        }
                        HStack{
                            Text("Fecha de Nacimiento").fontWeight(.bold)
                            DatePicker("",selection: $date,displayedComponents: [.date])
                        }
                        HStack{
                            Text("Teléfono").fontWeight(.bold)
                            TextField("Numero",value: $number,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                            
                        }.padding(.bottom, 20)
                        //                    Spacer().frame(minHeight: 50, maxHeight: 100)
                    }
                    Button(action: {
                        progress = true
                        if pass == confPassword{
                            
                            loginShow.show = "Home"
                            
                        }else{
                            showError = true
                            errorMessage = "Contraseñas no coinciden"
                        }
                    }){
                        Text("Iniciar").font(.system( size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.background(
                        Capsule().fill(Color("ButtonColor"))
                    ).alert("FALTA TITULO ALERTA", isPresented:$showErrorr){
                    
                        Button("OK", role: .cancel){
                            progress = false
                        }
                    } message: {
                        Text(errorMessage)
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
