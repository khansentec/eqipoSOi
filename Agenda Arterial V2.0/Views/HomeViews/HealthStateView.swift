//
//  HealthStateView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct HealthStateView: View {
    @State var comments = ""
    @State var symptomsPresent = false
    @State var symptoms = ""
    @State var feeling : Float = 5.0
    @State var healthReportSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    @State private var widthMenu = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            
            VStack{
                ScrollView{
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
                                        .frame(height: widthMenu == 375 ? 240 : 240, alignment: .center)
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
                                        .frame(height: widthMenu == 375 ? 240 : 240, alignment: .center)
                                    
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                                
                            }
                            .padding(.all)
                            
                            
                            Spacer()
                        }
                        Button("Enviar") {
                            
                            let id = UUID().uuidString
                            
                            let feelingR = round(feeling * 100) / 100.0
                            var newWR = HealthReport(id: id, feeling: feelingR, symptomsPresent: symptomsPresent, symptoms: symptoms, comments: comments)
                            
                            let processResults = newWR.uploadHR()
                            
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
                    }.padding(.init(top: 0, leading: 20, bottom: 350, trailing: 20))
                }.onTapGesture {
                    hideKeyboard()
                }.ignoresSafeArea(.all)
            }
        }
    }
}
