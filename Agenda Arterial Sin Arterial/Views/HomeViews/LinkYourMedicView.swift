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
        ZStack {
            VStack {
                VStack {
                    
                    Text("Médicos Vinculados").font(.title)
                    
                    NavigationView {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action:{
                                    
                                }){
                                    Image(systemName: "arrow.clockwise").aspectRatio(contentMode: .fill).foregroundColor(.black)
                                }
                            }
                            .padding(.trailing, 50)
                            
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
                            .overlay(Group{
                                if listMedics.isEmpty{
                                    Text("No hay médicos vinculados.")
                                }
                            })
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    
                    Button("Vincular") {
                        linkMedic.toggle()
                    }
                    .sheet(isPresented: $linkMedic){
                        AddMedicView()
                    }
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("ButtonColor"))
                    .frame(minWidth: 100,minHeight: 40))
                }
                .padding(.bottom, widthMenu == 375 ? 20 : 30)
            }
        }
    }
}
