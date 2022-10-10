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
    
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
    @State var id = ""
    @State var name = ""
    @State var patName = ""
    @State var matName = ""
    @State var photo = ""
    @State var sex = ""
    @State var birthDate = Date()
    @State var phone = ""
    @State var height = 0.0
    @State var weight = 0.0
    @State var cirAbdominal = 0.0
    @State var medDisease = ""
    @State var bloodType = ""
    @State var nextAppointment = Date()
    @State var currPaciente = Pacient(id: "", name: nil, patName: nil, matName: nil, photo: nil, sex: nil, pacientStatus: nil, birthDate: Date(), phone: nil, height: nil, weight: nil, cirAbdominal: nil, medDisease: nil, bloodType: nil, nextAppointment: nil, lastAppointment: nil, vinculationCode: nil, associatedMedic: nil)
    
    @State private var padecimientos: String = "Padecimientos aquí"
    
    @State var dataSubmitted = false
    @State var dataIsValid = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    func validateData() {
        let result = currPaciente.changeInfoPatient(newName: name, newPatName: patName, newMatName: matName, newPhoto: photo, newSex: sex, newBirthDate: birthDate, newPhone: phone, newHeight: height, newWeight: weight, newCirAbdominal: cirAbdominal, newMedDisease: medDisease, newBloodType: bloodType, newNextAppointment: nextAppointment)
        
        dataIsValid = result.0
        if dataIsValid {
            alertTitle = "¡Éxito!"
            alertMessage = "Datos guardados con éxito."
        }
        else {
            alertTitle = "Error"
            alertMessage = result.1
        }
        
        dataSubmitted = true
        
    }
=======
    @Binding var data : Pacient!
    
    @State private var progress = false
    
    @State var name = ""
    @State var lastNameP = ""
    @State var lastNameM = ""
    @State var height :Float = 0.0
    @State var cirAbdominal :Float = 0
    @State var weight :Float = 0
    @State private var disease: String = "No hay padecimientos ..."
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
    
    var body: some View {
        
        ZStack(alignment: .leading){
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
            
            VStack {
                NavBarHome(menu:$menu).onTapGesture {
=======
            Button(action: {
                progress = true
                
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
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
                    menu = false
                }
                Text("Datos Generales").bold().font(.title)
                ScrollView{
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
                    
                    VStack {
                        
                        if imageData.count != 0{
                            Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                        } else{
                            Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
=======
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                    
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
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
                        }
                        
                        Spacer(minLength: 15)
                        
                        Button(action: {showMenu.toggle()}){
                            Text("Tomar foto de pérfil")
                                .underline()
                        }
                        .confirmationDialog("Select an option: ", isPresented: $showMenu, actions: {
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
                            
                        })
                        .foregroundColor(Color("ButtonColor"))
                        
                    }
                    .padding(.bottom, 20)
                    
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black)
                        ProgressView()
                    }
                    
                    
                    VStack (spacing: 10) {
                        HStack{
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
=======
                            Text("Nombre")
                            TextField("Nombre", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                        HStack{
                            Text("Apellido Paterno")
                            TextField("Apellido Paterno", text: $lastNameP).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                        }
                        HStack{
                            Text("Apellido Materno")
                            TextField("Apellido Materno", text: $lastNameM).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                        }
                        HStack{
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
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
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
=======
                                
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
                        }
                        
                        HStack{
                            Text("Tipo de Sangre")
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
                            TextField("Tipo de Sangre", text: $bloodType).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        
                        Text("Padecimientos")
=======
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
                                .accentColor(Color("ButtonColor"))
                        }
                        
                        Text("Padecimientos")
                        HStack{
                            TextEditor(text: $disease).frame(width: widthMenu == 375 ? 270 : 270, height: 300, alignment: .leading)
                            
                            
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
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
                        HStack{
                            TextEditor(text: $padecimientos).frame(width: widthMenu == 375 ? 270 : 270, height: 300, alignment: .leading)
                            
                        }.overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                        
                        Button("Enviar"){
                            validateData()
                        }
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("ButtonColor"))
                            .frame(minWidth: 100,minHeight: 40))
                        
                        .alert(alertTitle, isPresented: $dataSubmitted){
                            Button("OK"){
                                //si se oprime quitar el ok
                            }
<<<<<<< HEAD:Agenda Arterial Sin Arterial/Views/SideBarViews/GeneralDataView.swift
                        } message: {
                            Text(alertMessage)
=======
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
>>>>>>> ofront:Agenda Arterial Sin Arterial/Views/SideBarView/GeneralDataView.swift
                        }
                    }
                    .padding(.init(top: 0, leading: 20, bottom: 50, trailing: 20))
                    
                }
                
            }
            .onTapGesture {
                menu = false
                hideKeyboard()
            }
            
            if menu{
                NavBarMenu(index: "Datos Generales", menu: false)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

