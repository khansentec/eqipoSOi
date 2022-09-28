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
                        VStack (alignment: .center){
                            Text("Sentimiento del día: ")
                            Slider(
                                value: $speed,
                                in: 0...10, minimumValueLabel: Text("Mal"), maximumValueLabel: Text("Bien")) { Text("") }
                            Text("\(speed, specifier:"%.1f")")
                        }
                        .padding()
                        
                        HStack{
                            Text("¿Ha tenido síntomas?")
                                .multilineTextAlignment(.leading)
                            
                            Picker(selection: $presenciaSintomas, label: Text("Picker")) {
                                Text("Sí").tag(true)
                                Text("No").tag(false)
                            }.frame(width : 70, height: 10)
                                .accentColor(.blue)
                                .padding(.top,-5)
                        }
                        .padding()
                        
                        VStack (alignment: .leading, spacing: 20) {
                            Text("Síntomas nuevas: ")
                            TextField("", text: $sentimiento)
                                .frame(height: 10.0)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(!presenciaSintomas)
                        }
                        .scenePadding()
                        
                        VStack (alignment: .leading) {
                            Text("Otros comentarios: ")
                        }
                        .scenePadding()
                        
                        VStack(alignment: .center){
                            HStack{
                                TextEditor(text: $comentarios)
                                    .frame(maxWidth: 320, maxHeight: 320, alignment: .center)
                                
                            }.overlay(RoundedRectangle(cornerRadius: 10)
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
