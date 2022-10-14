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
    @State var number = ""
    
    enum sex: String, CaseIterable, Identifiable {
        case nonseleceted, Masculino, Femenino, rathernot
        var id: Self { self }
    }
    
    @State private var selectedSex: sex = .nonseleceted
    
    @State private var date = Date()
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State var userSubmitted = false
    @State var complete = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    
    @State private var progress = false
    
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
                                Text("Hombre").tag("Masculino")
                                Text("Mujer").tag("Femenino")
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
                        let newUser = User(email: email, pass: pass, confPass: confPassword, name: name, ptName: patName, mtName: matName, bDate: date, phone: number, sex: selectedSex.rawValue)
                        
                        let processResults = newUser.uploadUser()
                        
                        alertTitle = processResults.1
                        alertMessage =  processResults.2
                        
                        userSubmitted = !processResults.0
                        
                        if processResults.0{
                            login.createUser(email: newUser.email, pass: newUser.pass, name: newUser.name, ptName: newUser.ptName, mtName: newUser.mtName, bDate: newUser.bDate, phone: newUser.phone, sex: newUser.sex){
                                (done, errorM) in
                                if done{
                                    alertTitle = "¡Éxito!"
                                    alertMessage = "La cuenta se ha creado correctamente"
                                    userSubmitted = true
                                    complete = true
                                }else{
                                    progress = false
                                    print(errorM)
                                    let t = type(of: errorM)
                                    print(t)
                                    alertMessage = errorM
                                    userSubmitted = true
                                }
                            }
                        }
                        
                        if processResults.0 {
                            name = ""
                            patName = ""
                            matName = ""
                            email = ""
                            pass = ""
                            confPassword = ""
                            number = ""
                            selectedSex = .nonseleceted
                        }
                    }){
                        Text("Iniciar").font(.system( size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.background(
                        Capsule().fill(Color("ButtonColor"))
                    )
                    .alert(alertTitle, isPresented: $userSubmitted) {
                        Button("OK", role: .cancel) {
                            progress = false
                            if complete{
                                loginShow.show = "Home"
                            }
                            
                        }
                    } message: {
                        Text(alertMessage)
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
