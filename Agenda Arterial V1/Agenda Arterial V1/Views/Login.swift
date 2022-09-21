//
//  Login.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 17/09/22.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var pass = ""
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white.edgesIgnoringSafeArea(.all)
            HStack(){
                Text("Titulo").font(.system(.title, design: .rounded)).bold().foregroundColor(.white).padding().frame(width: widthMenu,alignment: .leading)
            }.padding(.top, widthMenu == 375 ? 10 : 30).background(Color.blue)
            VStack(alignment: .center){
                Spacer().frame(minHeight: 10, maxHeight: 150)
                Image("isosceles").resizable().aspectRatio(contentMode: .fit).frame(width: widthMenu == 375 ? 70 : 130, height: widthMenu == 375 ? 70 : 130)
                Text("Agenda Arterial").font(.system(.title, design: .rounded)).bold().padding(.bottom, 15).foregroundColor(.black)
                VStack(alignment: .leading){
                    Text("Usuario").font(.body).foregroundColor(.black)
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.emailAddress)
                        .disableAutocorrection(true).autocapitalization(.none)
                        .frame(width: device == .pad ? 400 : 275)
                    Text("Contraseña").font(.body).foregroundColor(.black)
                    SecureField("Pass", text: $pass).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: device == .pad ? 400 : 275).padding(.bottom,40)
                }
                Button(action: {
                    
                    login.login(email: email, pass: pass){
                        (done) in
                        if done{
                            UserDefaults.standard.set(true, forKey: "sesion")
                            loginShow.show = "Home"
                            showError = false
                        }else{
                            showError = true
                        }
                    }
                }){
                    Text("Iniciar").font(.custom("Helvetica", size: 25)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5).bold()
                }.background(
                    Capsule().fill(Color("ButtonColor"))
                ).alert("The password is invalid or the user does not have a password.", isPresented: $showError) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
                HStack{
                    Button(action:{
                        
                    }){
                        Text("Políticas")
                    }.padding(.leading, 30)
                    Spacer()
                    HStack{
                        Button(action:{
                            
                        }){
                            Text("Olvidé mi contraseña").foregroundColor(.black).frame(width: 100)
                        }
                        Divider().frame(width: 1).overlay(.black)
                        Button(action:{
                            
                        }){
                            Text("Registrarse").foregroundColor(.black)
                        }
                    }.frame(height: 60).padding(.trailing, 30)
                    
                }.padding(.bottom, 45).padding(.top, 5)
            }
        }.frame(width: widthMenu).onTapGesture {
            hideKeyboard()
            
        }
        
    }
}



