//
//  MedicamentsView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import SwiftUI

struct MedicamentsView: View {
    
    
    @State var medicamentosList : [Medicament] = []
    
    @State var nombreMedicamento = ""
    @State var fecha = Date.now
    @State var frecuencia = ""
    @State var dosis = ""
    @State var indicaciones = ""
    @State var idPaciente = "12345"
    
    @State var agregarMedicamento = false
    @State var editar = false
    @State var alerta = false
    @State var showNavbar = true
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        ZStack{
            VStack{
                if showNavbar{
                    NavBarViews()
                }
                NavigationView{
                    List(){
                        ForEach(medicamentosList, id : \.self){
                            medicamento in
                            
                            NavigationLink(destination:MedicamentDetailsView(fechaInicio: medicamento.fechaInicio, medicamento: medicamento, info: medicamento.informacion, showNabar: $showNavbar), label: {
                                MedicamentView(medicamento: medicamento)
                            })
                        }.onDelete(perform: { idxSet in
                            medicamentosList.remove(atOffsets: idxSet)
                        })
                        
                        
                    }.overlay(Group{
                        if medicamentosList.isEmpty{
                            Text("No hay medicamentos")
                        }
                    })
                    .navigationTitle("Medicamentos").toolbar(content: {
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button(action: {
                                self.nombreMedicamento = ""
                                self.indicaciones = ""
                                self.frecuencia = ""
                                self.dosis = ""
                                self.agregarMedicamento.toggle()
                                
                                
                            }, label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            })
                        })
                        
                    })
                    .sheet(isPresented: $agregarMedicamento){
                        
                        AddMedicamentView(medicamentosList: $medicamentosList, agregarMedicamento: $agregarMedicamento)
                    }
                    
                }
            }
            
        }.onAppear{
            showNavbar = true
        }
    }
}

