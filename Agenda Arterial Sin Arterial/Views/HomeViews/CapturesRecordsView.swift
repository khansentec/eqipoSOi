//
//  CapturesRecordsView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 17/10/22.
//

import SwiftUI

struct CapturesRecordsView: View {
    
    @State var addMedicament = false
    @State var editing = false
    @State var error = false
    @State var showNavbar = true
    
    @State private var display = [MeditionRecord]()
    
    @State private var filter = false
    
    @StateObject var data = FirebaseViewController()
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    @State private var widthMenu = UIScreen.main.bounds.width
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            VStack{
                
                Text("Historial de Mediciones").font(.title)
                VStack(alignment: .leading){
                    VStack(){
                        VStack(alignment: .center){
                            HStack{
                                Text("Fecha de inicio: ").padding(.leading,widthMenu == 375 ? 70 : 60)
                                DatePicker("", selection: $startDate).padding(.trailing,60)
                            }
                            HStack{
                                Text("Fecha de final: ").padding(.leading,widthMenu == 375 ? 80 : 60)
                                DatePicker("", selection: $endDate).padding(.trailing,widthMenu == 375 ? 60 : 60)
                            }
                        }.padding(.bottom,10)
                        Button("Filtrar"){
                            if endDate < startDate{
                                filter.toggle()
                            }else{
                                data.getRecords(startDate: startDate, endDate: endDate)
                            }
                        }
                        .alert("¡Oops!", isPresented: $filter){
                            Button("OK"){
                                //si se oprime quitar el ok
                            }
                        } message: {
                            Text("La fecha de final debe ser mayor a la fecha de inicio")
                        }
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("ButtonColor"))
                            .frame(minWidth: 100,minHeight: 40))
                    }
                }.frame(width: widthMenu)
                ScrollView(.vertical, showsIndicators: false){
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 1), spacing: 5){
                        ForEach(data.records,id: \.self){ record in
                            HStack{
                                CaptureView(record: record).onTapGesture {
                                    data.sendRecord(item: record)
                                    editing.toggle()
                                }
                                
                            }
                        }.padding(.all)
                    }
                    .background(Color.clear)
                    .padding(.bottom,100)
                    .overlay(Group{
                        if data.records.isEmpty{
                            Text("No hay mediciones")
                        }
                        
                    })
                }
            }
            
        }
        .onAppear{ showNavbar = true }
    }
}
