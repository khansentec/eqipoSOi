//
//  LinkYourMedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct LinkYourMedicView: View {
    @State var listMedics = [Medic]()
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    @State var linkMedic = false
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @State var showNavbar = true
    
    var body: some View {
        ZStack{
            VStack{
<<<<<<< HEAD
                if showNavbar{
                    NavBarViews()
                }
                NavigationView{
                    
                    VStack{
                        List() {
=======
                VStack{
                    NavigationView{
                        List(){
>>>>>>> ofront
                            ForEach(listMedics, id : \.self){
                                medic in
                                MedicView(medic: medic)
                                
                            }.onDelete(perform: { idxSet in
                                listMedics.remove(atOffsets: idxSet)
                            })
                        }
                        .padding(.all).background(Color.clear)
                        .overlay(Group{
                            if listMedics.isEmpty{
                                Text("No hay ningunos médicos vinculados")
                            }
                        })
                        
                        Button("Vincular médico"){
                            linkMedic.toggle()
                        }
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("ButtonColor"))
                            .frame(minWidth: 150, minHeight: 40))
                        
<<<<<<< HEAD
                        .sheet(isPresented: $linkMedic){
                            AddMedicView()
                        }
                    }
                    .navigationBarTitle("Médicos vinculados", displayMode: .inline)
                    .padding(.bottom, 100)
                }
=======
                    }.navigationViewStyle(StackNavigationViewStyle())
                    Button(action:{
                        linkMedic.toggle()
                    }){
                        Text("Vincular").font(.system(size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.sheet(isPresented: $linkMedic){
                        AddMedicView()
                    }.background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("ButtonColor"))
                        .frame(minWidth: 150, minHeight: 40))
                    
                    
                }.padding(.bottom, widthMenu == 375 ? 20 : 30)
>>>>>>> ofront
            }
        }
    }
}
