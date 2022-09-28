//
//  RemindersViews.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct RemindersViews: View {
    // Lista de recordatorios heredada de la llamada a VistaCalendario
    @State var listaRecordatorios = [Remind]()
    
    @State var showNavbar = true
    
    var body: some View {
        ZStack{
            VStack{
                if showNavbar{
                    NavBarViews()
                }
                
                NavigationView {
                    VStack (alignment: .center) {
                        HStack (alignment: .top) {
                            VStack(alignment: .center, spacing: 20) {
                                Text("Recordatorios")
                                    .font(.title)
                                
                                ForEach(listaRecordatorios, id: \.id) {
                                    recordatorio in
                                    
                                    VStack (alignment: .center, spacing: 10) {
                                        Text(recordatorio.fecha)
                                            .fontWeight(.bold)
                                        VStack {
                                            ForEach(recordatorio.eventos, id: \.self) {
                                                evento in
                                                HStack {
                                                    Text(evento)
                                                }
                                            }
                                        }
                                    }
                                    .fixedSize(horizontal: true, vertical: false)
                                    .frame(width: 250)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.all)
                        
                        Spacer()
                    }
                    .overlay(Group{
                        if listaRecordatorios.isEmpty{
                            Text("No hay Recordatorios")
                        }
                    })
                }
            }
        }
    }
}

