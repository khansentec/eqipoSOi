//
//  HealthStateView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct HealthStateView: View {
    @State var symptoms = ""
    @State var comments = ""
    @State var symptomsPresent = false
    @State var feeling = 5.0
    @State var healthReportSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    
    var body: some View {
        ZStack{
            VStack{
                Text("Estado de Salud").font(.title)
                VStack (alignment: .leading) {
                    VStack (alignment: .leading){
                        HStack {
                            Text("Sentimiento del día: ")
                            Text("\(feeling, specifier:"%.1f")")
                        }
                        Slider(
                            value: $feeling,
                            in: 0...10,
                            minimumValueLabel: Text("Mal"),
                            maximumValueLabel: Text("Bien")
                        ) { Text("efhao") }
                    }
                    .padding()
                    
                    HStack{
                        Text("¿Ha tenido síntomas?")
                            .multilineTextAlignment(.leading)
                        
                        Picker(selection: $symptomsPresent, label: Text("Picker")) {
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
                            TextEditor(text: $symptoms)
                                .frame(maxHeight: 100, alignment: .center)
                                .disabled(!symptomsPresent)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                    }
                    .scenePadding()
                    
                    VStack (alignment: .leading) {
                        Text("Otros comentarios: ")
                        HStack{
                            TextEditor(text: $comments)
                                .frame(maxHeight: 240, alignment: .center)
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                        
                    }
                    .padding(.all)

                    VStack{
                        Button("Enviar") {
                            
                            var newWR = HealthReport

                            let processResults = newWR.uploadWR(feeling : feeling, symptomsPresent : symptomsPresent, symptoms : symptoms, comments : comments)
                            
                            alertTitle = processResults.1
                            alertMessage =  processResults.2

                            if processResults.0 {
                                symptoms = ""
                                comments = ""
                                symptomsPresent = false
                                feeling = 5.0
                            }

                            healthReportSubmitted = true

                        }
                        .foregroundColor(Color("ButtonColor"))
                        .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("ButtonColor"), lineWidth: 1)
                        .frame(minWidth: 100,minHeight: 40))
                        .alert(alertTitle, isPresented: $healthReportSubmitted){
                            
                            Button("OK"){
                                //si se oprime quitar el ok
                            }
                        } message: {
                            Text(alertMessage)
                        }
                    }.padding()
                    
                    Spacer()
                }
            }
        }
    }
}
