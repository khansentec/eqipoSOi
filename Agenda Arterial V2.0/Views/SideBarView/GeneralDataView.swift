//
//  GeneralDataView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

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
    
    @Binding var data : Pacient!
    
    @State private var progress = false
    
    @State var name = ""
    @State var lastNameP = ""
    @State var lastNameM = ""
    @State var height :Float = 0.0
    @State var cirAbdominal :Float = 0
    @State var weight :Float = 0
    @State var bloodType = ""
    @State private var disease: String = "No hay padecimientos ..."
    @State private var email = Auth.auth().currentUser?.email
    
    var body: some View {
        ZStack(alignment: .leading){
            Button(action: {
                progress = true
                save.saveGD(height: height, abdominalCir: Float(cirAbdominal), sintoms: disease, weight: Float(weight), bType: bloodType, photo: imageData){
                    (done)in
                    if done{
                        progress = false
                    }
                }
            }){
                Text("Guardar").foregroundColor(.white).font(.system(size: 25, weight: .bold))
            }.padding(.bottom, heightMenu-360)
            .zIndex(1)
            .padding(.leading, widthMenu-120)
            .background{
                    RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("ButtonColor"))
                    .frame(width: 100,height: 40)
                    .padding(.bottom, heightMenu-360)
                    .zIndex(1)
                    .padding(.leading, widthMenu-120)
                    
                }
                
            VStack{
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                Text("Datos Generales").bold().font(.title)
                ScrollView{
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                    }else if data.photo != ""{
                        ImageFirebase(imageUrl: data.photo)
                    }else{
                        Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
                    }
                    Button(action:{
                        showMenu.toggle()
                    }){
                        Text("Tomar Foto de Perfil").foregroundColor(.black).bold().font(.system( size: 17, weight: .heavy)).underline()
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
                        
                    }).sheet(isPresented: $imagePicker){
                        ImagePicker(show: $imagePicker, image: $imageData, source: source)
                    }.padding(.bottom, 20)
                    
                    
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black)
                        ProgressView()
                    }
                    
                    
                    VStack (spacing: 10) {
                        HStack{
                            Text("Nombre")
                            TextField("Nombre", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true).onAppear{
                                    name = data.name
                                }
                        }
                        HStack{
                            Text("Apellido Paterno")
                            TextField("Apellido Paterno", text: $lastNameP).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true).onAppear{
                                    lastNameP = data.patName
                                }
                            
                        }
                        HStack{
                            Text("Apellido Materno")
                            TextField("Apellido Materno", text: $lastNameM).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true).onAppear{
                                    lastNameM = data.matName
                                }
                            
                        }
                        HStack{
                            Text("Altura")
                            TextField("Altura",value: $height,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).onAppear{
                                height = data.height
                            }
                        }
                        
                        HStack{
                            Text("Peso")
                            TextField("Peso",value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).onAppear{
                                weight = data.weight
                            }
                        }
                        
                        HStack{
                            Text("Circuferencia Abdominal")
                            TextField("Circuferencia Abdominal",value: $cirAbdominal,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                                .onAppear{
                                    cirAbdominal = data.cirAbdominal
                                }
                        }
                        
                        HStack{
                            Text("Tipo de Sangre")
                            TextField("Tipo de Sangre", text: $bloodType).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true).onAppear{
                                    bloodType = data.bloodType
                                }
                        }
                        
                        Text("Padecimientos")
                        HStack{
                            TextEditor(text: $disease).frame(width: widthMenu == 375 ? 270 : 270, height: 300, alignment: .leading).onAppear{
                                disease = data.medDisease
                            }
                            
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
                }
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
                                Text("Datos Generales").foregroundColor(.blue).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
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
                                try! Auth.auth().signOut()
                                UserDefaults.standard.removeObject(forKey: "sesion")
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

