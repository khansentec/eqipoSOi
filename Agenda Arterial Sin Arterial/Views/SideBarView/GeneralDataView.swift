/*
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
 
 var body: some View {
 ZStack(alignment: .leading){
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
 withAnimation{
 menu = false
 }
 }
 Text("Datos Generales").bold().font(.title)
 ScrollView{
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
 }
 Button(action: {
 source = .photoLibrary
 imagePicker.toggle()
 }){
 Text("Library")
 }
 
 }).padding(.bottom, 20)
 
 
 if progress{
 Text("Please Wait One Moment...").foregroundColor(.black)
 ProgressView()
 }
 
 
 VStack (spacing: 10) {
 HStack{
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
 .stroke(Color.gray.opacity(0.2), lineWidth: 1))
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
 .font(.system(size:  widthMenu == 375 ? 18 : 19, weight: .bold)).foregroundColor(Color("ButtonColor"))
 .foregroundColor(.white)
 Text("Datos Generales").foregroundColor(Color("ButtonColor")).font(.system(size:  widthMenu == 375 ? 12 : 13, weight: .bold))
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
 Text("Sign Out").font(.title).fontWeight(.bold).foregroundColor(Color("ButtonColor"))
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
 */

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
            
            VStack {
                
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    menu = false
                }
                
                ScrollView (showsIndicators: false) {
                    
                    Text("Datos Generales").bold().font(.title)
                    
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                        
                    } else {
                        Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
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
                    
                    Spacer(minLength: 30)
                    
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black)
                        ProgressView()
                    }
                    
                    
                    VStack (alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Nombre")
                            TextField("Nombre", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                        HStack {
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
                            Text("Altura")
                            TextField("Altura",value: $height,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Peso")
                            TextField("Peso",value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Circunferencia Abdominal")
                            TextField("Circunferencia Abdominal",value: $cirAbdominal,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Tipo de Sangre")
                            Picker("Tipo de Sangre", selection: $bloodType) {
                                Text("Selecione una opcion").tag("non selected")
                                Text("O+").tag("O+")
                                Text("O-").tag("O-")
                                Text("AB+").tag("AB+")
                                Text("AB-").tag("AB-")
                                Text("A+").tag("A+")
                                Text("A-").tag("A-")
                                Text("B+").tag("B+")
                                Text("B-").tag("B-")
                            }
                            .frame(width : 200, height: 20)
                            .accentColor(Color("ButtonColor"))
                        }
                        VStack (alignment: .leading, spacing: 5){
                            Text("Padecimientos")
                            HStack{
                                TextEditor(text: $disease)
                                    .frame(width: widthMenu-50, height: 300, alignment: .leading)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    Button("Enviar"){
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
                    }
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("ButtonColor"))
                        .frame(minWidth: 100,minHeight: 40))
                    
                    Spacer()
                    
                }
                .padding(30)
            }
            if menu{
                NavBarMenu(index: $index, menu: $menu)
            }
        }
        .onTapGesture {
            withAnimation{
                menu = false
            }
            hideKeyboard()
        }
        
    }
    
    
}

