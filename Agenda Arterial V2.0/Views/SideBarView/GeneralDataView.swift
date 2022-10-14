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
    @State private var editingPhoto = false
    @State private var imageData : Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    @State private var photourl = ""
    
    @State private var bloodType = "non selected"
    
    @State private var selectedSex = "non selected"
    @EnvironmentObject var loginShow : FirebaseViewController
    @StateObject var save = FirebaseViewController()
    
    @State private var dataL : Pacient?
    
    @State private var progress = false
    
    @State var name = ""
    @State var lastNameP = ""
    @State var lastNameM = ""
    @State var phoneNumber = ""
    @State var height :Float = 0.0
    @State var cirAbdominal :Float = 0
    @State var weight :Float = 0
    @State private var disease: String = "No hay padecimientos ..."
    @State private var email = Auth.auth().currentUser?.email
    @State private var date = Date()
    @State var infoSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    
    var body: some View {
        ZStack(alignment: .leading){
            Button(action: {
                
                progress = true
                save.saveGD(name: name, lastNP: lastNameP, lastNM: lastNameM, phone: phoneNumber, sex: selectedSex, height: height, abdominalCir: cirAbdominal, diseases: disease, weight: weight, bType: bloodType, photo: imageData, urlPhoto: save.data.photo, editingPhoto: editingPhoto){
                    (done)in
                    if done{
                        progress = false
                        print("Succesfully upload info")
                    }else{
                        print("ERROR Uploading info")
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
                .alert(alertTitle, isPresented: $infoSubmitted) {
                    Button("OK", role: .cancel) {
                        progress = false
                    }
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
                        
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle()).onAppear{
                            editingPhoto = true
                        }
                    }else{
                        
                        if photourl != ""{
                            ImageFirebase(imageUrl: photourl)
                        }else{
                            Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
                        }
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
                        VStack{
                            HStack{
                                Text("Nombre")
                                TextField("Nombre", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disableAutocorrection(true)
                            }
                            HStack{
                                Text("Apellido Paterno")
                                TextField("Apellido Paterno", text: $lastNameP).textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disableAutocorrection(true).onAppear{
                                        //                                        lastNameP = save.data.patName
                                    }
                                
                            }
                            HStack{
                                Text("Apellido Materno")
                                TextField("Apellido Materno", text: $lastNameM).textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disableAutocorrection(true)
                                
                            }
                            
                        }
                        HStack{
                            Text("Teléfono")
                            TextField("Teléfono", text: $phoneNumber).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                        }
                        HStack{
                            Text("Sexo").fontWeight(.bold)
                            Picker("", selection: $selectedSex) {
                                Text("Selecione una opcion").tag("non selected")
                                Text("Masculino").tag("Masculino")
                                Text("Femenino").tag("Femenino")
                                Text("Prefiero no decir").tag("rathernot")
                            }.frame(width : 200, height: 20)
                                .accentColor(Color("ButtonColor"))
                            
                        }
                        HStack{
                            Text("Fecha de Nacimiento").fontWeight(.bold)
                            DatePicker("",selection: $date,displayedComponents: [.date])
                               
                        }
                        HStack{
                            Text("Altura")
                            TextField("Altura",value: $height,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack{
                            Text("Peso")
                            TextField("Peso",value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack{
                            Text("Circuferencia Abdominal")
                            TextField("Circuferencia Abdominal",value: $cirAbdominal,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack{
                            Text("Tipo de Sangre")
                            Picker("Selecione una opcion", selection: $bloodType) {
                                Text("Selecione una opcion").tag("non selected")
                                Text("O+").tag("O+")
                                Text("O-").tag("O-")
                                Text("AB+").tag("AB+")
                                Text("AB-").tag("AB-")
                                Text("A+").tag("A+")
                                Text("A-").tag("A-")
                                Text("B+").tag("B+")
                                Text("B-").tag("B-")
                            }.frame(width : 200, height: 20)
                                .accentColor(Color("ButtonColor"))
                        }
                        
                        Text("Padecimientos")
                        HStack{
                            TextEditor(text: $disease).frame(width: widthMenu == 375 ? 270 : 270, height: 300, alignment: .leading).onAppear{
                                //                                disease = save.data.medDisease
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
        }.onAppear{
            save.getPacient(){
                (done)in
                if done{
                    name = save.data.name
                    photourl = save.data.photo
                    lastNameP = save.data.patName
                    lastNameM = save.data.matName
                    phoneNumber = save.data.phoneNumber
                    selectedSex = save.data.sex
                    date = save.data.birthDate
                    height = save.data.height
                    cirAbdominal = save.data.cirAbdominal
                    weight = save.data.weight
                    bloodType = save.data.bloodType
                    disease = save.data.medDisease
                }
            }
            
        }
    }
}

