//
//  LinkYourMedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
import Firebase

struct LinkYourMedicView: View {
    @Binding var listMedics : [Medic]
    @State var linkCode = [Int]()
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    @State var linkMedic = false
    @State private var widthMenu = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    
                    NavigationView{
                        List(){
                            ForEach(listMedics, id : \.self){
                                medic in
                                MedicView(medic: medic)
                                
                            }.onDelete(perform: { idxSet in
                                listMedics.remove(atOffsets: idxSet)
                            })
                            
                            
                        }.padding(.all).background(Color.clear).padding(.bottom,10).overlay(Group{
                            if listMedics.isEmpty{
                                Text("No hay Medicos Vinculados")
                            }
                        })
                        
                        
                    }.navigationViewStyle(StackNavigationViewStyle())
                    Button(action:{
                        if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                            login.getMedics()
                            listMedics = login.medics
                        }
                    }){
                        Image(systemName: "arrow.clockwise").resizable().frame(width: 50, height: 50).padding(.trailing,10).foregroundColor(.black)
                    }
                    Button(action:{
                        linkCode = login.generateLinkCode(){
                            (done) in
                            if done{
                                
                                print(linkCode)
                                linkMedic = true
                            }else{
                                print("Error firebase")
                            }
                        }
                    }){
                        Text("Vincular").font(.system(size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.sheet(isPresented: $linkMedic){
                        AddMedicView(linkCode: $linkCode)
                    }.background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("ButtonColor"))
                        .frame(minWidth: 150, minHeight: 40))
                    
                    
                }.padding(.bottom, widthMenu == 375 ? 20 : 30)
            }
        }
    }
}
