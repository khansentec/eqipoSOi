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
                        linkMedic.toggle()
                    }){
                        Text("Vincular").font(.system(size: 25, weight: .heavy)).frame(width: 200).foregroundColor(.white).padding(.vertical, 5)
                    }.sheet(isPresented: $linkMedic){
                        AddMedicView()
                    }.background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("ButtonColor"))
                        .frame(minWidth: 150, minHeight: 40))
                    
                    
                }.padding(.bottom, widthMenu == 375 ? 20 : 30)
            }
        }
    }
}
