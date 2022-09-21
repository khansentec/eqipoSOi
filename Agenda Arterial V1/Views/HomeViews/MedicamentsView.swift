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
        ZStack(alignment: .bottomTrailing){
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
                            }).background(Color.clear)
                        }.onDelete(perform: { idxSet in
                            medicamentosList.remove(atOffsets: idxSet)
                        })
                        
                        
                    }.padding(.all).background(Color.clear).padding(.bottom,100).overlay(Group{
                        if medicamentosList.isEmpty{
                            Text("No hay medicamentos")
                        }
                    })
                    
                    .navigationTitle("Medicamentos").navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $agregarMedicamento){
                        
                        AddMedicamentView(medicamentosList: $medicamentosList, agregarMedicamento: $agregarMedicamento)
                    }
                    
                }.background(Color.clear)
                
            }
            Button(action: {
                self.nombreMedicamento = ""
                self.indicaciones = ""
                self.frecuencia = ""
                self.dosis = ""
                self.agregarMedicamento.toggle()
                
                
            }){
                Image(systemName: "plus").bold().font(.system(size: 40))
                    .foregroundColor(.white).padding(.bottom,40).padding(.trailing,40).frame(width: 100, height: 100)
            }.background{
                Circle().fill(Color.blue).padding(.bottom,40).padding(.trailing,40)
            }.opacity(showNavbar ? 1 : 0)
        }.onAppear{
            showNavbar = true
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
