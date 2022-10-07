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
    @State var pulse1 = 0
    @State var presionSupStr2 = ""
    @State var presionInfStr2 = ""
    @State var pulse2 = 0
    @State var presionSupStr3 = ""
    @State var presionInfStr3 = ""
    @State var pulse3 = 0
    
    @State var invalidCaptureError = false
    
    @State var dateCapture = Date.now
    
    @State var status = true
    @State var timerShow = false
    @State var timerTime = 0
    
    @State var validation1 = false
    @State var validation2 = false
    @State var validation3 = false
    @State var message1 = ""
    @State var message2 = ""
    @State var message3 = ""
    
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var heighthMenu = UIScreen.main.bounds.height
    
    var med = Medition(fecha: Date.now)
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        
        ZStack{
            VStack(alignment: .center){
                Text("Capturas De Presión").font(.title)
                ScrollView(.vertical, showsIndicators: false){
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
                                        .accentColor(.blue)
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
                                            .foregroundColor(.blue)
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
                                            .foregroundColor(.blue)
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
                                            .foregroundColor(.blue)
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
                                .foregroundColor(.blue)
                                .padding(.bottom,20)
                                .padding(.trailing,70)
                                .padding(.leading,0)
                            
                            Button("Enviar") {
                                med.changeDate(newDate: dateCapture)
                                let validacionCaptura1 = med.validateCapture(presionSupStr: presionSupStr1, presionInfStr: presionInfStr1, pulse: pulse1)
                                
                                validation1 = validacionCaptura1.0
                                message1 = validacionCaptura1.1
                                
                                print(validacionCaptura1)
                                
                                let validacionCaptura2 = med.validateCapture(presionSupStr: presionSupStr2, presionInfStr: presionInfStr2, pulse: pulse2)
                                
                                validation2 = validacionCaptura2.0
                                message2 = validacionCaptura2.1
                                
                                print(validacionCaptura2)
                                
                                let validacionCaptura3 = med.validateCapture(presionSupStr: presionSupStr3, presionInfStr: presionInfStr3, pulse: pulse3)
                                
                                validation3 = validacionCaptura3.0
                                message3 = validacionCaptura3.1
                                
                                print(validacionCaptura3)
                                
                                if (!validation1  || !validation2 || !validation3) || message1 == "Sin datos" {
                                    invalidCaptureError = true
                                }else{
                                    
                                    if validation1{
                                        let presionSup1 = Int(presionSupStr1)!
                                        let presionInf1 = Int(presionInfStr1)!
                                        
                                        
                                        let cap1 = Capture(presionSup: presionSup1, presionInf: presionInf1, pulse: pulse1)
                                        med.addCapture(newCapture: cap1)
                                        
                                    }
                                    if validation2 && message2 != "Sin datos"{
                                        let presionSup2 = Int(presionSupStr2)!
                                        let presionInf2 = Int(presionInfStr2)!
                                        
                                        let cap2 = Capture(presionSup: presionSup2, presionInf: presionInf2, pulse: pulse2)
                                        med.addCapture(newCapture: cap2)
                                        
                                    }
                                    if validation3 && message3 != "Sin datos" {
                                        let presionSup3 = Int(presionSupStr3)!
                                        let presionInf3 = Int(presionInfStr3)!
                                        
                                        let cap3 = Capture(presionSup: presionSup3, presionInf: presionInf3, pulse: pulse3)
                                        med.addCapture(newCapture: cap3)
                                    }
                                    
                                    med.calculateAvg()
                                    print(med.avgSup)
                                    print(med.avgInf)
                                    print(med.avgPulse)
                                    
//                                    loginShow.saveBP(state: "verde", dateC: med.meditionDate, pressureS: med.avgSup, pressureD: med.avgInf, pulse: med.avgPulse){(done)
//                                        in
//                                        if done{
//                                            pulse1 = 0
//                                            pulse2 = 0
//                                            pulse3 = 0
//                                        }
//                                    }
                                    
                                    
                                    
                                }
                            }.alert("Error", isPresented: $invalidCaptureError){
                                
                                Button("OK"){
                                    //si se oprime quitar el ok
                                }
                            } message: {
                                if !validation1 && message1 != "Sin datos"{
                                    Text(message1)
                                }else if !validation2 && message2 != "Sin datos" {
                                    Text(message2)
                                } else if !validation3 && message3 != "Sin datos" {
                                    Text(message3)
                                }else {
                                    Text("Debe ingresar datos en Captura 1")
                                }
                            }.foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("ButtonColor"))
                                    .frame(minWidth: 100,minHeight: 40))
                            
                        }
                        
                    }.padding(.all).padding(.bottom, 50)
                    
                }
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

