//
//  CapturesView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import SwiftUI

struct CapturesView: View {
    
    @State var presionSupStr1 = ""
    @State var presionInfStr1 = ""
    @State var pulso1 = 0
    @State var presionSupStr2 = ""
    @State var presionInfStr2 = ""
    @State var pulso2 = 0
    @State var presionSupStr3 = ""
    @State var presionInfStr3 = ""
    @State var pulso3 = 0
    
    @State var fecha = Date.now
    
    @State var estado = true
    @State var idPaciente = "12345"
    
    @State var timerShow = false
    @State var tiempoRestante = 0
    
    @State var meditionIsValid = false
    @State var meditionSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    @State var newCaptures : [Capture] = []
    
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heighthMenu = UIScreen.main.bounds.height
    @State var showNavbar = true
    
    var med = Medition(idPaciente: "", fecha: Date.now)
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func validateData() {
        med.cambiarIDPaciente(nuevoIdPaciente: idPaciente)
        med.cambiarFecha(nuevaFecha: fecha)
        
        // Tuple containing validation status, alert message, and new medition object
        let validationResults = validateMedition(med: med,
                                                 presionSupStr1: presionSupStr1, presionInfStr1: presionInfStr1, pulso1: pulso1,
                                                 presionSupStr2: presionSupStr2, presionInfStr2: presionInfStr2, pulso2: pulso2,
                                                 presionSupStr3: presionSupStr3, presionInfStr3: presionInfStr3, pulso3: pulso3)
        meditionIsValid = validationResults.0
        if meditionIsValid {
            alertTitle = "¡Éxito!"
        } else {
            alertTitle = "¡Oops!"
        }
        alertMessage = validationResults.1
        newCaptures = validationResults.2
        meditionSubmitted = true
    }
    
    var body: some View {
        
        ZStack{
            VStack{
                if showNavbar{
                    NavBarViews().padding(.bottom, 15)
                }
                
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1), spacing: 20){
                            VStack() {
                                VStack(alignment: .leading, spacing: 6){
                                    HStack{
                                        Text("¿Se encuentra relajado?")
                                            .padding(.bottom,5)
                                        Picker(selection: $estado, label: Text("Picker")) {
                                            Text("Sí").tag(true)
                                            Text("No").tag(false)
                                        }.frame(width : 80, height: 10)
                                            .accentColor(Color("ButtonColor"))
                                            .padding(.top,-5)
                                    }
                                    
                                    Text("Si selecciono 'No', no debe hacerse la captura en este momento")
                                        .padding(.bottom,20)
                                        .font(.system(size : 10))
                                        .multilineTextAlignment(.leading)
                                        .padding(.trailing, 30)
                                    HStack {
                                        Text("Captura 1")
                                        
                                        TextField("Superior", text: $presionSupStr1)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        Text("/")
                                        TextField("Inferior", text: $presionInfStr1)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        Button(action:{
                                            tiempoRestante =  300
                                            timerShow.toggle()
                                        }) {
                                            Image(systemName: "clock")
                                                .imageScale(.large)
                                                .foregroundColor(Color("ButtonColor"))
                                        }.sheet(isPresented: $timerShow, content: {
                                            TimerView(timerTime: $tiempoRestante)
                                        })
                                        
                                    }
                                    
                                    HStack{
                                        Text("Pulso")
                                        TextField("Pulso", value: $pulso1, formatter: NumberFormatter())
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        
                                    }
                                    .padding(.top,15)
                                    .padding(.bottom,20)
                                    
                                    HStack {
                                        Text("Captura 2")
                                        TextField("Superior", text: $presionSupStr2)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize() .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        Text("/")
                                        TextField("Inferior", text: $presionInfStr2)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        Button(action:{
                                            tiempoRestante =  120
                                            timerShow.toggle()
                                        }) {
                                            Image(systemName: "clock")
                                                .imageScale(.large)
                                                .foregroundColor(Color("ButtonColor"))
                                        }.sheet(isPresented: $timerShow, content: {
                                            TimerView(timerTime: $tiempoRestante)
                                        })
                                    }
                                    HStack{
                                        Text("Pulso")
                                        TextField("Pulso", value: $pulso2, formatter: NumberFormatter())
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .keyboardType(.numberPad).disabled(!estado)
                                            .disabled(!estado)
                                    }
                                    .padding(.top,15)
                                    .padding(.bottom,20)
                                    
                                    HStack {
                                        Text("Captura 3")
                                        TextField("Superior", text: $presionSupStr3)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        Text("/")
                                        TextField("Inferior", text: $presionInfStr3)
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                        
                                        Button(action:{
                                            tiempoRestante =  120
                                            timerShow.toggle()
                                        }) {
                                            Image(systemName: "clock")
                                                .imageScale(.large)
                                                .foregroundColor(Color("ButtonColor"))
                                        }.sheet(isPresented: $timerShow, content: {
                                            TimerView(timerTime: $tiempoRestante)
                                        })
                                    }
                                    HStack{
                                        Text("Pulso")
                                        TextField("Pulso", value: $pulso3, formatter: NumberFormatter())
                                            .font(.system(size: device == .pad ? 16 : 12))
                                            .frame(width:device == .pad ? 80 : 65)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .keyboardType(.numberPad)
                                            .disabled(!estado)
                                    }
                                    .padding(.top,15)
                                    .padding(.bottom,20)
                                }
                                .padding(.leading,15)
                                
                                Text("Ingresa la fecha y hora:")
                                    .padding(.bottom,20)
                                
                                DatePicker("", selection: $fecha)
                                    .foregroundColor(Color("ButtonColor"))
                                    .padding(.bottom,20)
                                    .padding(.trailing,70)
                                    .padding(.leading,0)
                                
                                Button("Enviar"){
                                    validateData()
                                }
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("ButtonColor"))
                                    .frame(minWidth: 100,minHeight: 40))
                                
                                .alert(alertTitle, isPresented: $meditionSubmitted){
                                    Button("OK"){
                                        //si se oprime quitar el ok
                                    }
                                } message: {
                                    if meditionIsValid {
                                        Text("Datos subidos con éxito.")
                                    } else {
                                        Text(alertMessage)
                                    }
                                }
                            }
                        }
                        .padding(.all).padding(.bottom, 50)
                    }
                    .navigationBarTitle("Capturas de presión", displayMode: .inline)
                }
            }
        }
    }
}

