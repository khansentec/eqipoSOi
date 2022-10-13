//
//  CapturesView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct CapturesView: View {
    @State var presionSupStr1 = ""
    @State var presionInfStr1 = ""
    @State var pulse1 : Int = 0
    @State var presionSupStr2 = ""
    @State var presionInfStr2 = ""
    @State var pulse2 : Int = 0
    @State var presionSupStr3 = ""
    @State var presionInfStr3 = ""
    @State var pulse3 : Int = 0
    
    @State var dateCapture = Date.now
    
    @State var status = true
    
    @State var timerShow = false
    @State var timerTime = 0
    
    //-----------------------------------------------------
    @State var meditionSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heighthMenu = UIScreen.main.bounds.height
    @State var showNavbar = true
    
    @State private var captures = [Capture]()
    
    //-------------------------------------------------------------
    
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    //--------------------------------------------------
    
    
    @State var validation1 = false
    @State var validation2 = false
    @State var validation3 = false
    @State var message1 = ""
    @State var message2 = ""
    @State var message3 = ""
    
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    
    var body: some View {
        
        ZStack{
            VStack(alignment: .center){
                Text("Capturas De Presión").font(.title)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1), spacing: 20){
                        VStack() {
                            VStack(alignment: .leading, spacing: 6){
                                HStack{
                                    Text("¿Se encuentra relajado?")
                                        .padding(.bottom,5)
                                    Picker(selection: $status, label: Text("Picker")) {
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
                                        .disabled(!status)
                                    Text("/")
                                    TextField("Inferior", text: $presionInfStr1)
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .disabled(!status)
                                    Button(action:{
                                        timerTime =  300
                                        timerShow.toggle()
                                    }) {
                                        Image(systemName: "clock")
                                            .imageScale(.large)
                                            .foregroundColor(Color("ButtonColor"))
                                    }.sheet(isPresented: $timerShow, content: {
                                        TimerView(timerTime: $timerTime)
                                    })
                                    
                                }
                                
                                HStack{
                                    Text("Pulso")
                                    TextField("Pulso", value: $pulse1, formatter: NumberFormatter())
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .fixedSize()
                                        .keyboardType(.numberPad)
                                        .disabled(!status)
                                    
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
                                        .disabled(!status)
                                    Text("/")
                                    TextField("Inferior", text: $presionInfStr2)
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .disabled(!status)
                                    Button(action:{
                                        timerTime =  120
                                        timerShow.toggle()
                                    }) {
                                        Image(systemName: "clock")
                                            .imageScale(.large)
                                            .foregroundColor(Color("ButtonColor"))
                                    }.sheet(isPresented: $timerShow, content: {
                                        TimerView(timerTime: $timerTime)
                                    })
                                }
                                HStack{
                                    Text("Pulso")
                                    TextField("Pulso", value: $pulse2, formatter: NumberFormatter())
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .fixedSize()
                                        .keyboardType(.numberPad).disabled(!status)
                                        .disabled(!status)
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
                                        .disabled(!status)
                                    Text("/")
                                    TextField("Inferior", text: $presionInfStr3)
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .disabled(!status)
                                    
                                    Button(action:{
                                        timerTime =  120
                                        timerShow.toggle()
                                    }) {
                                        Image(systemName: "clock")
                                            .imageScale(.large)
                                            .foregroundColor(Color("ButtonColor"))
                                    }.sheet(isPresented: $timerShow, content: {
                                        TimerView(timerTime: $timerTime)
                                    })
                                }
                                HStack{
                                    Text("Pulso")
                                    TextField("Pulso", value: $pulse3, formatter: NumberFormatter())
                                        .font(.system(size: device == .pad ? 16 : 12))
                                        .frame(width:device == .pad ? 80 : 65)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .fixedSize()
                                        .keyboardType(.numberPad)
                                        .disabled(!status)
                                }
                                .padding(.top,15)
                                .padding(.bottom,20)
                            }
                            .padding(.leading,15)
                            
                            Text("Ingresa la fecha y hora:")
                                .padding(.bottom,20)
                            
                            DatePicker("", selection: $dateCapture)
                                .foregroundColor(Color("ButtonColor"))
                                .padding(.bottom,20)
                                .padding(.trailing,70)
                                .padding(.leading,0)
                            
                            Button("Enviar"){
                                let capture1 = Capture(presionSup: presionSupStr1, presionInf: presionInfStr1, pulse: pulse1)
                                let capture2 = Capture(presionSup: presionSupStr2, presionInf: presionInfStr2, pulse: pulse2)
                                let capture3 = Capture(presionSup: presionSupStr3, presionInf: presionInfStr3, pulse: pulse3)
                                
                                let medition = Medition(date: dateCapture, captures: [capture1,capture2,capture3])
                                
                                let validation = medition.validateMedition()
                                
                                alertTitle = validation.1
                                alertMessage =  validation.2
                                
                                if validation.0 {
                                    pulse1 = 0
                                    pulse2 = 0
                                    pulse3 = 0
                                    presionSupStr1 = ""
                                    presionSupStr2 = ""
                                    presionSupStr3 = ""
                                    presionInfStr1 = ""
                                    presionInfStr2 = ""
                                    presionInfStr3 = ""
                                    
                                    
                                }
                                
                                meditionSubmitted = true
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
                                Text(alertMessage)
                            }
                        }
                    }
                    .padding(.all).padding(.bottom, 50)
                }
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

