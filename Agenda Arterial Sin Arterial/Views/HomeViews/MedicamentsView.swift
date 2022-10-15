//
//  MedicamentsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentsView: View {
    @State var medicamentName = ""
    @State var startDate = Date.now
    @State var frecuency = ""
    @State var dosis = ""
    @State var indications = ""
    
    @State var addMedicament = false
    @State var editing = false
    @State var error = false
    @State var showNavbar = true
    
    @StateObject var data = FirebaseViewController()
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            VStack{
                
                Text("Medicamentos").font(.title)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(data.meds,id: \.self){ medicament in
                            HStack{
                                MedicamentView(medicament: medicament).onTapGesture {
                                    data.sendMed(item: medicament)
                                    editing.toggle()
                                }
                            }
                        }.sheet(isPresented: $editing){
                            data.getMedicaments()
                            
                        } content: {
                            MedicamentDetailsView(medicament: data.medUpdate, showNabar: $showNavbar)
                        }.padding(.all)
                    }
                    .background(Color.clear)
                        .padding(.bottom,100)
                        .overlay(Group{
                            if data.meds.isEmpty{
                                Text("No hay medicamentos")
                            }
                            
                        })
                }.onAppear{
                    data.getMedicaments()
                }
            }
            Button(action: {
                self.medicamentName = ""
                self.indications = ""
                self.frecuency = ""
                self.dosis = ""
                self.addMedicament.toggle()
                
            }){
                Image(systemName: "plus").font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.white).padding(.bottom,40).padding(.trailing,40).frame(width: 100, height: 100)
            }
            .background{
                Circle().fill(Color("ButtonColor")).padding(.bottom,40).padding(.trailing,40)
            }
            .opacity(showNavbar ? 1 : 0).sheet(isPresented: $addMedicament){
                data.getMedicaments()
            }content:{
                AddMedicamentView(addMedicament: $addMedicament)
            }
            
        }
        .onAppear{ showNavbar = true }
    }
    
}

