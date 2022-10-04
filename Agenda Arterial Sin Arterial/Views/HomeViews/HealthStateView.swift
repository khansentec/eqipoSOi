//
//  HealthStateView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct HealthStateView: View {
    
    @State var descanso = ""
    @State var sentimiento = ""
    @State var comentarios = ""
    @State var presenciaSintomas = false
    @State private var speed = 5.0
    
    @State var showNavbar = true
    
    var body: some View {
        ZStack{
            VStack{
                if showNavbar{
                    NavBarViews()
                }
                NavigationView {
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading){
                            HStack {
                                Text("Sentimiento del día: ")
                                Text("\(speed, specifier:"%.1f")")
                            }
                            Slider(
                                value: $speed,
                                in: 0...10,
                                minimumValueLabel: Text("Mal"),
                                maximumValueLabel: Text("Bien")
                            ) { Text("efhao") }
                        }
                        .padding()
                        
                        HStack{
                            Text("¿Ha tenido síntomas?")
                                .multilineTextAlignment(.leading)
                            
                            Picker(selection: $presenciaSintomas, label: Text("Picker")) {
                                Text("Sí").tag(true)
                                Text("No").tag(false)
                            }
                            .frame(width : 70, height: 10)
                                .accentColor(Color("ButtonColor"))
                                .padding(.top,-5)
                        }
                        .padding()
                        
                        VStack (alignment: .leading) {
                            Text("Síntomas nuevas: ")
                            HStack {
                                TextEditor(text: $sentimiento)
                                    .frame(maxHeight: 100, alignment: .center)          .disabled(!presenciaSintomas)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                        }
                        .scenePadding()
                        
                        VStack (alignment: .leading) {
                            Text("Otros comentarios: ")
                            HStack{
                                TextEditor(text: $comentarios)
                                    .frame(maxHeight: 240, alignment: .center)
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                            
                        }
                        .padding(.all)
                    }
                    .navigationBarTitle("Estado de salud", displayMode: .inline)
                    Spacer()
                }
            }
        }
    }
}
