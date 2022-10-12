//
//  Login.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
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
    
    @State private var progress = false
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack(alignment: .top){
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                Spacer().frame(minHeight: 10, maxHeight: 150)
                Image("isosceles").resizable().aspectRatio(contentMode: .fit).frame(width: widthMenu == 375 ? 70 : 130, height: widthMenu == 375 ? 70 : 130)
                Text("Agenda Arterial").font(.system(size: device == .pad ? 60: widthMenu == 375 ? 25 : 25, design: .rounded)).bold().padding(.bottom, 15).foregroundColor(.black)
                VStack(alignment: .leading){
                    Text("Usuario").font(.system(size: device == .pad ? 32: widthMenu == 375 ? 18 : 18)).foregroundColor(.black)
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.emailAddress)
                        .disableAutocorrection(true).autocapitalization(.none)
                        .frame(width: device == .pad ? 400 : 275).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                    Text("Contraseña").font(.system(size: device == .pad ? 32: widthMenu == 375 ? 18 : 18)).foregroundColor(.black)
                    SecureField("Contrseseña", text: $pass).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: device == .pad ? 400 : 275).padding(.bottom,20).font(.system(size: device == .pad ? 30 : widthMenu == 375 ? 18 : 18))
                }
                Button(action: {
                    progress = true
                    
                    loginShow.show = "Home"
                    
                }){
                    Text("Iniciar").font(.system(size: device == .pad ? 32: widthMenu == 375 ? 22 : 22,weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                }.background(
                    Capsule().fill(Color("ButtonColor"))
                ).alert("The password is invalid or the user does not have a password.", isPresented: $showError) {
                    Button("OK", role: .cancel) {
                        progress = false
                    }
                }
                if progress{
                    Text("Please Wait One Moment...").foregroundColor(.black)
                    ProgressView()
                }
                Spacer()
                HStack{
                    Button(action:{
                        
                    }){
                        Text("Políticas").font(.system(size: device == .pad ? 32: widthMenu == 375 ? 18 : 18))
                    }.padding(.leading, 30)
                    Spacer()
                    HStack{
                        Button(action:{
                            withAnimation{
                                loginShow.show = "SignIn"
                            }
                        }){
                            Text("Registrarse").foregroundColor(.black).foregroundColor(.black).font(.system(size: device == .pad ? 32: widthMenu == 375 ? 18 : 18))
                        }
                        
                    }.frame(height: 60).padding(.trailing, 30)
                    
                }.padding(.bottom, 45).padding(.top, 5)
            }
        }.frame(width: widthMenu).onTapGesture {
            hideKeyboard()
            
        }
        
    }
}
