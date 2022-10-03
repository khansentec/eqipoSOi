//
//  LinkYourMedicView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
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
                if showNavbar{
                    NavBarViews()
                }
                NavigationView{
                    
                    VStack{
                        List() {
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
                        
                        .sheet(isPresented: $linkMedic){
                            AddMedicView()
                        }
                    }
                    .navigationBarTitle("Médicos vinculados", displayMode: .inline)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

