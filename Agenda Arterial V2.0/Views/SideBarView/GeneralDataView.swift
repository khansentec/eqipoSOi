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
    
    enum bloodT: String, CaseIterable, Identifiable {
        case nonseleceted, oP, oN, aP, aN, bP, bN, abP, abN
        var id: Self { self }
    }
    @State private var bloodType: bloodT = .nonseleceted
    
    enum sex: String, CaseIterable, Identifiable {
        case nonseleceted, male, female, rathernot
        var id: Self { self }
    }
    @State private var selectedSex: sex = .nonseleceted
    
    @StateObject var save = FirebaseViewController()
    
    @Binding var data : Pacient!
    
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
                save.saveGD(name: name, lastNP: lastNameP, lastNM: lastNameM, phone: phoneNumber, sex: selectedSex.rawValue, height: height, abdominalCir: cirAbdominal, diseases: disease, weight: weight, bType: bloodType.rawValue, photo: imageData, urlPhoto: data.photo){
                    (done)in
                    if done {
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
                .alert(alertTitle, isPresented: $infoSubmitted) {
                    Button("OK", role: .cancel) {
                        progress = false
                        Text(alertMessage)
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
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                    }else{
                        
                        if loginShow.data.photo != ""{
                            ImageFirebase(imageUrl: loginShow.data.photo)
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
                            
                        }
                        HStack{
                            Text("Teléfono")
                            TextField("Teléfono", text: $phoneNumber).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true).onAppear{
                                    phoneNumber = data.phoneNumber
                                }
                            
                        }
                        HStack{
                            Text("Sexo").fontWeight(.bold)
                            Picker("", selection: $selectedSex) {
                                Text("Selecione una opcion").tag(sex.nonseleceted)
                                Text("Masculino").tag(sex.male)
                                Text("Femenino").tag(sex.female)
                                Text("Prefiero no decir").tag(sex.rathernot)
                            }.frame(width : 200, height: 20)
                                .accentColor(Color("ButtonColor"))
                                .onAppear{
                                    switch data.sex {
                                    case "Selecione una opcion" :
                                        selectedSex = sex.nonseleceted
                                    case "Masculino" :
                                        selectedSex = sex.male
                                    case "Femenino" :
                                        selectedSex = sex.female
                                    case "Prefiero no decir":
                                        selectedSex = sex.rathernot
                                    default:
                                        selectedSex = sex.nonseleceted
                                    }
                                }
                            
                        }
                        HStack{
                            Text("Fecha de Nacimiento").fontWeight(.bold)
                            DatePicker("",selection: $date,displayedComponents: [.date])
                                .onAppear{
                                    date = data.birthDate
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
                            }.frame(width : 200, height: 20)
                                .accentColor(Color("ButtonColor")).onAppear{
                                    switch data.bloodType {
                                    case "O+" :
                                        bloodType = bloodT.oP
                                    case "O-" :
                                        bloodType = bloodT.oN
                                    case "AB+" :
                                        bloodType = bloodT.abP
                                    case "AB-" :
                                        bloodType = bloodT.abN
                                    case "A+" :
                                        bloodType = bloodT.aP
                                    case "A-" :
                                        bloodType = bloodT.aN
                                    case "B+" :
                                        bloodType = bloodT.bP
                                    case "B-" :
                                        bloodType = bloodT.bN
                                    default:
                                        bloodType = bloodT.nonseleceted
                                    }
                                    
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
                }.onAppear{
                    loginShow.getPacient()
                    print("Login desde general: \(loginShow.data.name)")
                    data = loginShow.data
                }
                Spacer()
                
            }.onAppear{
                print(loginShow.data.name)
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

