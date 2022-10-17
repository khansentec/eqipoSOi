//
//  Login.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var tittlealert = "No se pudo iniciar sesión"
    @State private var messagealert = "La contraseña o el usuario es inválido"
    @State private var pass = ""
    @State private var showPolitics = false
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var progress = false
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack(alignment: .top){
            
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                
                Spacer()
                    .frame(minHeight: 10, maxHeight: 150)
                
                VStack {
                    Image("corazon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: widthMenu == 375 ? 150 : 200, height: widthMenu == 375 ? 75 : 100)
                    Text("Agenda Arterial").font(.system(.title, design: .rounded)).bold().padding(.bottom, 15).foregroundColor(.black)
                }
                
                Spacer()
                    .frame(minHeight: 50, maxHeight: 70)
                
                VStack(alignment: .leading){
                    Text("Usuario").font(.body).foregroundColor(.black)
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.emailAddress)
                        .disableAutocorrection(true).autocapitalization(.none)
                        .frame(width: device == .pad ? 400 : 275)
                    
                    Spacer()
                        .frame(minHeight: 30, maxHeight: 30)
                    
                    Text("Contraseña").font(.body).foregroundColor(.black)
                    SecureField("Contrseseña", text: $pass).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: device == .pad ? 400 : 275).padding(.bottom,20)
                }
                Button(action: {
                    progress = true
                    login.login(email: email, pass: pass){
                        (done) in
                        if done{
                            showError = true
                            UserDefaults.standard.set(true, forKey: "sesion")
                            tittlealert = "Exito"
                            messagealert = "Se pudo iniciar sesión"
                            loginShow.show = "Home"
                        }else{
                            showError = true
                        }
                    }
                }){
                    Text("Iniciar")
                        .font(.system( size: 25))
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                }
                .background(
                    Capsule().fill(Color("ButtonColor"))
                )
                .alert(tittlealert, isPresented: $showError) {
                    Button("OK", role: .cancel) {
                        progress = false
                    }
                }message: {
                    Text(messagealert)
                }
                if progress{
                    Text("Por Favor espere...").foregroundColor(.black)
                    ProgressView()
                }
                Spacer()
                HStack{
                    Button(action:{
                        showPolitics.toggle()
                    }){
                        Text("Políticas")
                    }.padding(.leading, 30)
                        .popover(isPresented: $showPolitics){
                            Politics()
                        }
                    Spacer()
                    HStack{
                        Button(action:{
                            withAnimation{
                                loginShow.show = "RestorePassword"
                            }
                        }){
                            Text("Olvidé mi contraseña").foregroundColor(.black).frame(width: 100)
                        }
                        Divider().frame(width: 1).overlay(.black)
                        Button(action:{
                            withAnimation{
                                loginShow.show = "SignIn"
                            }
                        }){
                            Text("Registrarse").foregroundColor(.black)
                        }
                        
                    }
                    .frame(height: 60).padding(.trailing, 30)
                }
                .padding(.bottom, 45).padding(.top, 5)
            }
        }
        .frame(width: widthMenu)
        .onTapGesture { hideKeyboard() }
    }
}
