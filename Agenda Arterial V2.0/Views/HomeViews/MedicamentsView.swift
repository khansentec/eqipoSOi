//
//  MedicamentsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentsView: View {
    @State var medicamentosList = [Medicament]()
    
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
    
    
    func deleteItems(at offsets: IndexSet) {
        medicamentosList.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            VStack{
                Text("Medicamentos").font(.title)
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(medicamentosList,id: \.self){ medicament in
                            MedicamentView(medicament: medicament).onTapGesture {
                                data.sendMed(item: medicament)
                                editing.toggle()
                            }
                        }.onDelete(perform: deleteItems).sheet(isPresented: $editing, content: {
                            MedicamentDetailsView(startDate: data.medUpdate.startDate, medicament: data.medUpdate, info: data.medUpdate.information, showNabar: $showNavbar)
                        }).padding(.all)
                    }.background(Color.clear)
                        .padding(.bottom,100)
                        .overlay(Group{
                            if medicamentosList.isEmpty{
                                Text("No hay medicamentos")
                            }
                            
                        })
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
            }.background{
                Circle().fill(Color.blue).padding(.bottom,40).padding(.trailing,40)
            }.opacity(showNavbar ? 1 : 0).sheet(isPresented: $addMedicament){
                
                AddMedicamentView(medsList: $medicamentosList, addMedicament: $addMedicament)
            }
            
        }.onAppear{
            showNavbar = true
        }
        
    }
    
}

