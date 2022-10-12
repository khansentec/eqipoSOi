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
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var progress = false
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View {
        
        ZStack{
            VStack{
                NavbarLogin(title: "Iniciar Sesion", whereTo: "Login")
                Text("Registro").fontWeight(.heavy).padding(.horizontal).padding(.vertical).font(.system(size: device == .pad ? 35: widthMenu == 375 ? 20 : 20))
                VStack{
                    VStack{
                        HStack{
                            Text("Nombre").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            TextField("Nombre",text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Apellido Paterno").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            TextField("Apellido Paterno",text: $patName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Apellido Materno").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            TextField("Apellido Materno",text: $matName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Correo Electronico").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            TextField("Correo",text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                        }
                        HStack{
                            Text("Contraseña").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            SecureField("",text: $pass).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Confirmar Contraseña").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            SecureField("",text: $confPassword).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                        }
                        HStack{
                            Text("Sexo").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            Picker("", selection: $selectedSex) {
                                Text("Selecione una opcion").tag(sex.nonseleceted)
                                Text("Hombre").tag(sex.male)
                                Text("Mujer").tag(sex.female)
                                Text("Prefiero no decir").tag(sex.rathernot)
                            }.frame(width : 300, height: 20).scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                                .accentColor(Color("ButtonColor"))
                                .font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                            
                        }
                        HStack{
                            Text("Fecha de Nacimiento").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            DatePicker("",selection: $date,displayedComponents: [.date]).scaledToFit().scaleEffect(CGSize(width: 1.25 ,height: 1.25))
                        }
                        HStack{
                            Text("Numero de Celular").fontWeight(.bold).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            TextField("Numero",value: $number,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                            
                        }.padding(.bottom, 20)
                        //                    Spacer().frame(minHeight: 50, maxHeight: 100)
                    }.frame(width: device == .phone ? 300 : widthMenu == 1024 ? 900 : 700 )
                    
                    Button(action: {
                        progress = true
                        if pass == confPassword{
                            
                            loginShow.show = "Home"
                            
                        }else{
                            showError = true
                            errorMessage = "Contraseñas no coinciden"
                        }
                    }){
                        Text("Iniciar").font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 20 : 20, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
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
