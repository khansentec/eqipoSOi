//
//  LinkYourMedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct LinkYourMedicView: View {
    
    @Binding var listMedics : [Medic]
    @State var linkCode = [Int]()
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    @State var linkMedic = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var showError = false
    @State private var progress = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    
                    HStack (alignment: .center) {
                        Text("Médicos Vinculados").font(.title)
                        Spacer()
                        Button(action:{
                            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                                login.getMedics()
                                listMedics = login.medics
                            }
                        }){
                            Image(systemName: "arrow.clockwise").aspectRatio(contentMode: .fill).foregroundColor(.black)
                        }
                    }
                    .padding(30)
                    
                    NavigationView{
                        if (!progress) {
                            
                            List(){
                                ForEach(listMedics, id : \.self){
                                    medic in
                                    MedicView(medic: medic)
                                    
                                }.onDelete(perform: { idxSet in
                                    listMedics.remove(atOffsets: idxSet)
                                })
                                
                            }
                            .padding(.all)
                            .background(Color.clear)
                            .padding(.bottom,10)
                            .overlay(Group{
                                if listMedics.isEmpty{
                                    Text("No hay médicos vinculados")
                                }
                            })
                        }
                        else {
                            Text("Generando código...").foregroundColor(.black)
                            ProgressView()
                        }
                        
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                
                Button("Vincular") {
                    progress = true
                    linkCode = login.generateLinkCode(){
                        (done) in
                        if done {
                            progress = false
                            linkMedic = true
                        } else {
                            progress = false
                            showError = true
                        }
                    }
                }
                .sheet(isPresented: $linkMedic) {
                    AddMedicView(linkCode: $linkCode)
                }
                .alert("¡Oops!", isPresented: $showError){
                    
                    Button("OK"){
                        //si se oprime quitar el ok
                    }
                } message: {
                    Text("Hay un problema con la red. Favor de intentar de nuevo.")
                }
                
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("ButtonColor"))
                    .frame(minWidth: 110,minHeight: 50))
            }
            
        }
        .padding(.bottom, widthMenu == 375 ? 40 : 60)
    }
}
}

