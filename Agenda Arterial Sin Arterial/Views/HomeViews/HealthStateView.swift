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
    @EnvironmentObject var loginShow : FirebaseViewController
    @State var alertMessage = ""
    @State var alertTitle = ""
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var submitted = false
    var body: some View {
        ZStack{
            VStack{
                Text("Estado de Salud").font(.title)
                ScrollView{
                    VStack {
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
                            }                        .frame(width : 70, height: 10)
                            .accentColor(Color("ButtonColor"))
                            .padding(.top,-5)
                        }
                        .padding()
                        
                        VStack (alignment: .leading) {
                            Text("Síntomas nuevos: ")
                            HStack {
                                TextEditor(text: $symptoms)
                                    .frame(height: 100, alignment: .center)
                                    .disabled(!symptomsPresent)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)).frame(alignment: .center)
                        }
                        .scenePadding()
                        
                        VStack (alignment: .leading) {
                            Text("Otros comentarios: ")
                            HStack{
                                TextEditor(text: $comments)
                                    .frame(height: 150, alignment: .center)
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)).frame(alignment: .center)
                            
                        }
                        .padding(.all)
                        
                        Button("Enviar") {
                            
                            let id = UUID().uuidString
                            
                            let feelingR = round(feeling * 100) / 100.0
                            var newWR = HealthReport(id: id, feeling: feelingR, symptomsPresent: symptomsPresent, symptoms: symptoms, comments: comments)
                            
                            let processResults = newWR.uploadHR()
                            submitted = processResults.0
                            alertTitle = processResults.1
                            alertMessage =  processResults.2
                            
                            if processResults.0 {
                                symptoms = ""
                                comments = ""
                                symptomsPresent = false
                                feeling = 5.0
                            }
                            
                            healthReportSubmitted = true
                        }.alert(alertTitle, isPresented: $healthReportSubmitted){
                            Button("OK"){
                                
                                
                                if submitted{
                                    loginShow.showApp = "Home"
                                    loginShow.show = "Home"
                                }
                            }
                        } message: {
                            Text(alertMessage)
                        }
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("ButtonColor"))
                        .frame(minWidth: 100,minHeight: 40))
                        
                        Spacer()
                    }
                }
                
            }.keyboardManagment()
        }.onTapGesture {
            hideKeyboard()
        }
    }
}
