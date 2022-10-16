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
    @State private var dataSubmitted = false
    
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
                        if photourl != ""{
                            ImageFirebase(imageUrl: photourl)
                        }else{
                            Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
                        }
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
                    .foregroundColor(Color("ButtonColor")).sheet(isPresented: $imagePicker){
                        ImagePicker(show: $imagePicker, image: $imageData, source: source)
                    }.padding(.bottom, 20)
                    
                Spacer(minLength: 15)
                    
               
                
                
                VStack (alignment: .leading, spacing: 15) {
                    VStack{
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
                            Text("Teléfono")
                            TextField("Teléfono", text: $phoneNumber).textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                        }
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
                    
                    HStack {
                        Text("Peso")
                        TextField("Peso",value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Text("Circunferencia Abdominal")
                        TextField("Circunferencia Abdominal",value: $cirAbdominal,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
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
                    if progress{
                        Text("Please Wait One Moment...").foregroundColor(.black)
                        ProgressView()
                    }
                Button("Enviar"){
                    progress = true
                    let idUser = Auth.auth().currentUser?.uid
                    let pacientUpdate = Pacient(id: idUser! , name: name, patName: lastNameP, matName: lastNameP, photo: photourl, sex: selectedSex, pacientStatus: "", birthDate: date, phone: phoneNumber, height: height, weight: weight, cirAbdominal: cirAbdominal, medDisease: disease, bloodType: bloodType, vinculationCode: "", associatedMedic: [])
                    
                    let valid = pacientUpdate.changeInfoPatient()
                    print(valid.0)
                    print(valid.1)
                    if valid.0{
                        save.saveGD(name: name, lastNP: lastNameP, lastNM: lastNameM, phone: phoneNumber, sex: selectedSex, height: height, abdominalCir: cirAbdominal, diseases: disease, weight: weight, bType: bloodType, photo: imageData, urlPhoto: save.data.photo, editingPhoto: editingPhoto, birthDate: date){
                            (done)in
                            if done{
                                dataSubmitted = true
                                progress = false
                                alertTitle = "¡Éxito!"
                                alertMessage = "Datos subido con éxito."
                            }else{
                                dataSubmitted = true
                                alertTitle = "¡Oops!"
                                alertMessage = "Ocurrió un error con subir los datos."
                            }
                            dataSubmitted = true
                        }
                    }else{
                        dataSubmitted = true
                        alertTitle = "¡Oops!"
                        alertMessage = valid.1
                    }
                    
                }
                .alert(alertTitle, isPresented: $dataSubmitted){
                    Button("OK"){
                        //si se oprime quitar el ok
                        progress = false
                    }
                } message: {
                    Text(alertMessage)
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

