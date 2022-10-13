//
//  GeneralDataView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct GeneralDataView: View {
    @State private var index = "Datos Generales"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heightMenu = UIScreen.main.bounds.height
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @StateObject var save = FirebaseViewController()
    
    enum bloodT: String, CaseIterable, Identifiable {
        case nonseleceted, oP, oN, aP, aN, bP, bN, abP, abN
        var id: Self { self }
    }
    @State private var bloodType: bloodT = .nonseleceted
    
    @Binding var data : Pacient!
    
    @State private var progress = false
    
    @State var name = ""
    @State var lastNameP = ""
    @State var lastNameM = ""
    @State var height :Float = 0.0
    @State var cirAbdominal :Float = 0
    @State var weight :Float = 0
    @State private var disease: String = "No hay padecimientos ..."
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View {
        ZStack(alignment: .leading){
            Button(action: {
                progress = true
                
            }){
                Text("Guardar").foregroundColor(.white).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18 , weight: .bold))
            }.padding(.bottom,widthMenu == 1024 ? heightMenu-380 : heightMenu-400)
            .zIndex(1)
            .padding(.leading,widthMenu == 1024 ? widthMenu-200 : widthMenu-180)
            .background{
                    RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("ButtonColor"))
                    .frame(minWidth: device == .pad ? 150 :widthMenu == 375 ? 100 : 100, minHeight: device == .pad ?60 : widthMenu == 375 ? 40 : 40)
                    .padding(.bottom,widthMenu == 1024 ? heightMenu-380 : heightMenu-400)
                    .zIndex(1)
                    .padding(.leading,widthMenu == 1024 ? widthMenu-200 : widthMenu-180)
                    
                }
                
            VStack{
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                Text("Datos Generales").font(.system(size: device == .pad ? 40: widthMenu == 375 ? 20 : 20)).bold()
                ScrollView{
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                    
                    }else{
                        Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 200, height: 200).clipShape(Circle())
                    }
                    Button(action:{
                        showMenu.toggle()
                    }){
                        Text("Tomar Foto de Perfil").foregroundColor(.black).bold().font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18 , weight: .heavy)).underline()
                    }.confirmationDialog("Select an option: ", isPresented: $showMenu, actions: {
                        Button(action: {
                            source = .camera
                            imagePicker.toggle()
                        }){
                            Text("Camera")
                        }
                        Button(action: {
                            source = .photoLibrary
                            imagePicker.toggle()
                        }){
                            Text("Library")
                        }
                        
                    }).padding(.bottom, 20)
                    
                    
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        ProgressView()
                    }
                    
                    
                    VStack (spacing: 10) {
                        HStack{
                            Text("Nombre").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Nombre", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }
                        HStack{
                            Text("Apellido Paterno").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Apellido Paterno", text: $lastNameP).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Apellido Materno").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Apellido Materno", text: $lastNameM).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            
                        }
                        HStack{
                            Text("Altura").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Altura",value: $height,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }
                        
                        HStack{
                            Text("Peso").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Peso",value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }
                        
                        HStack{
                            Text("Circuferencia Abdominal").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            TextField("Circuferencia Abdominal",value: $cirAbdominal,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                
                        }
                        
                        HStack{
                            Text("Tipo de Sangre").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)).padding(.all)
                            Picker("Selecione una opcion", selection: $bloodType) {
                                Text("Selecione una opcion").tag(GeneralDataView.bloodT.nonseleceted)
                                Text("O+").tag(bloodT.oP)
                                Text("O-").tag(bloodT.oN)
                                Text("AB+").tag(bloodT.abP)
                                Text("AB-").tag(bloodT.abN)
                                Text("A+").tag(bloodT.aP)
                                Text("A-").tag(bloodT.aN)
                                Text("B+").tag(bloodT.bP)
                                Text("B-").tag(bloodT.bN)
                            }.frame(width : 250, height: 25)
                                .scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                                .accentColor(Color("ButtonColor"))
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }
                        
                        Text("Padecimientos").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        HStack{
                            TextEditor(text: $disease)
                            //.frame(width: device == .pad ? 900 :widthMenu == 375 ? 270 : 270, height: device == .pad ? 400 : 300, alignment: .leading)
                            //.frame( device == .pad ? widthMenu == 1024 ? 900 : 600  : widthMenu == 375 ? 270 : 270 ,height: device == .pad ? widthMenu == 1024 ? 400 : 300 : 300  ,aligment: .leading)
                                .frame(width: device == .pad ? widthMenu == 1024 ? 900 : 600  : widthMenu == 375 ? 270 : 270 ,height: device == .pad ? widthMenu == 1024 ? 400 : 300 : widthMenu == 375 ? 300:300 ,alignment: .leading)
                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            
                            
                        }.overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                        /*
                         Button("Enviar"){
                            validateData()
                         }
                         .foregroundColor(.white)
                         .background(RoundedRectangle(cornerRadius: 5)
                         .foregroundColor(Color("ButtonColor"))
                         .frame(minWidth: 100,minHeight: 40))
                         */
                       
                    }
                    .padding(.init(top: 0, leading: 20, bottom: 350, trailing: 20))
                    //.frame(width: device == .pad ? 900 : 350)
                    //frame(width: device == .phone ? 300 : widthMenu == 1024 ? 900 : 700 )
                }.frame(width: device == .phone ? 350 : widthMenu == 1024 ? 900 : 700 )
                Spacer()
                
            }.onTapGesture {
                withAnimation{
                    menu = false
                }
                hideKeyboard()
            }
            
            if menu{
                HStack{
                    VStack{
                        HStack{
                            Button(action: {
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "arrow.left")
                                    .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(.blue)
                                    .foregroundColor(.white)
                                Text("Datos Generales").foregroundColor(.blue).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18 , weight: .bold))
                            }
                            Spacer()
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .leading){
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 25 : 32).padding(.bottom,10)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "SettingsView", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 16)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "GeneralDataView", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.leading,widthMenu == 375 ? 15 : 21)
                            Spacer()
                            Button(action: {
                                
                                loginShow.show = "Login"
                            }){
                                Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(.blue)
                            }.padding(.all).padding(.leading, 30).padding(.bottom, 20)
                        }
                        Spacer()
                    }.frame(width: widthMenu-200).background(Color("BlueBBVA"))
                }
                
            }
            
            
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

