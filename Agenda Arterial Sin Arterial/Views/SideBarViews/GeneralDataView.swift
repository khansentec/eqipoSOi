//
//  GeneralDataView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 22/09/22.
//

import SwiftUI

struct GeneralDataView: View {
    
    @State private var index = "Datos Generales"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @StateObject var save = FirebaseViewController()
    
    @State private var progress = false
    
    @State var height = 0
    @State var cirAbdominal = 0
    @State var weight = 0
    @State var bloodType = 0
    @State private var padecimientos: String = "This is some editable text..."
    
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu:$menu).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                if imageData.count != 0{
                    Image(uiImage: UIImage(data: imageData)!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
                }else{
                    Image(systemName: "person.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 125, height: 125).clipShape(Circle())
                }
                Button(action:{
                    showMenu.toggle()
                }){
                    Text("Tomar Foto de Perfil").foregroundColor(.black).bold().font(.system( size: 17, weight: .heavy))
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
                    
                })
                
                
                if progress{
                    Text("Please Wait One Moment...").foregroundColor(.black)
                    ProgressView()
                }
                
                HStack{
                    Text("Altura").fontWeight(.bold)
                    TextField("Altura",value: $height,formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    
                }.padding(.bottom, 20)
                
                Text("Padecimientos").fontWeight(.bold)
                HStack{
                    TextEditor(text: $padecimientos)
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading)
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1))
                
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
                            ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "gearshape.fill", title: "Configuración").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "", img: "person.crop.circle", title: "Datos Generales").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "FrecuentlyAskedQuestionsView", img: "checkmark" , title: "Preguntas Frecuentes").padding(.bottom,10).padding(.leading,widthMenu == 375 ? 15 : 21)
                            ButtonNavbar(index: $index, menu: $menu,whereto: "Home", img: "house" , title: "Menu Principal").padding(.leading,widthMenu == 375 ? 25 : 32)
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
