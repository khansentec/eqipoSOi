//
//  WeekReportView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//
import SwiftUI

struct WeekReportView: View {
    @State var followDiet : Float = 5.0
    @State var saltConsumption : Float = 5.0
    @State var beveragesIntake = false
    @State var numBeverages = 0
    @State var physicalActivity : Float = 5.0
    @State var numPhysicalActivity = 0
    @State var sleepHours = 0
    @State var followMedicalPresciption = true
    @State var reportDate = Date.now
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @State var weekReportSubmitted = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    @State var forgetTimes = 0
    
    @StateObject var save = FirebaseViewController()
    
    var body: some View {
        VStack{
            Text("Reporte Semanal").font(.title)
            ScrollView{
                
                VStack {
                    DisclosureGroup("Alimentacion") {
                        VStack(spacing : 15){
                            Text("¿Has seguido con la dieta?")
                            Slider(value: $followDiet, in: 0...10, minimumValueLabel: Text("No"), maximumValueLabel: Text("Si")) { Text("") }.frame(width: 200)
                            Text("\(followDiet, specifier:"%.1f")")
                            Text("¿Como ha sido tu consumo de sal?")
                                .multilineTextAlignment(.center)
                            Slider(value: $saltConsumption, in: 0...10, minimumValueLabel: Text("Poco").font(.system(size: 14)), maximumValueLabel: Text("Mucho").font(.system(size: 14))) { Text("") }.frame(width: 230)
                            Text("\(saltConsumption, specifier:"%.1f")")
                            HStack{
                                Text("¿Has consumido\nrefrescos?")
                                    .multilineTextAlignment(.leading)
                                
                                Picker(selection: $beveragesIntake, label: Text("Picker")) {
                                    Text("Sí").tag(true)
                                    Text("No").tag(false)
                                }.frame(width : widthMenu == 375 ? 80 : 70, height: 10)
                                    .accentColor(Color("ButtonColor"))
                                    .padding(.top,-5)
                            }.padding(.leading,-50)
                            HStack{
                                Text("Cantidad de refrescos: ")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 13))


                                TextField("Numero", value: $numBeverages, formatter: NumberFormatter())
                                    .font(.system(size: device == .pad ? 16 : 12))
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                                    .disabled(!beveragesIntake)
                                
                            }
                        }.padding()
                        
                    }.padding(.bottom,5)
                    
                    Divider().background(Color("ButtonColor"))
                    
                    DisclosureGroup("Ejercicio") {
                        VStack(spacing : 15){
                            Text("¿Cómo ha sido tu actividad física?").multilineTextAlignment(.center)
                            
                            Slider(value: $physicalActivity, in: 0...10, minimumValueLabel: Text("Mala"), maximumValueLabel: Text("Buena")) { Text("") }
                            Text("\(physicalActivity, specifier:"%.1f")")
                            Text("¿Cuántas veces te has ejercitado esta semana?")
                                .multilineTextAlignment(.center)

                            TextField("Numero", value: $numPhysicalActivity, formatter: NumberFormatter())
                                    .font(.system(size: device == .pad ? 16 : 12))
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                        }.padding()
                        
                    }.padding(.bottom,5)
                    
                    Divider().background(Color("ButtonColor"))
                    
                    DisclosureGroup("Descanso") {
                        VStack{
                            Text("Durante esta semana,¿Cuántas horas dormiste en promedio al día ?")
                                .multilineTextAlignment(.center)

                            TextField("Numero", value: $sleepHours, formatter: NumberFormatter())
                                    .font(.system(size: device == .pad ? 16 : 12))
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                        }.padding()
                    }.padding(.bottom,5)
                    
                    Divider().background(Color("ButtonColor"))
                    
                    DisclosureGroup("Medicamentos") {
                        VStack{
                            HStack{
                                Text("Durante esta semana, \n¿Ha cumplido con la receta?")
                                    .multilineTextAlignment(.leading)
                                Picker(selection: $followMedicalPresciption, label: Text("Picker")) {
                                    Text("Sí").tag(true)
                                    Text("No").tag(false)
                                }.frame(width : widthMenu == 375 ? 60 : 70, height: 10)
                                    .accentColor(Color("ButtonColor"))
                                    .padding(.top,-5)
                                
                            }.padding()
                            VStack(alignment: .center){
                                Text("Si indica 'No',¿Cuántas veces se te han olvidado tus medicamentos ?")
                                    .multilineTextAlignment(.center)
                            }.padding()
                            
                            List($save.meds){ $medicament in
                                VStack{
                                    VStack{
                                        Text(medicament.medicamentName)
                                            .multilineTextAlignment(.center)
                                        HStack{
                                            TextField("Numero", value: $medicament.forgetTimes, formatter: NumberFormatter())
                                                .font(.system(size: device == .pad ? 16 : 12))
                                                .frame(minWidth: 15, maxWidth: 50)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .fixedSize()
                                                .keyboardType(.numberPad).onAppear{
                                                    medicament.forgetTimes = 0
                                                }
                                                
      
                                        }
                                    }.padding(.all, 10)
                                    
                                }.frame(width: widthMenu == 375 ? 250 : 270)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("ButtonColor"), lineWidth: 1))
                                    .listRowSeparator(.hidden)
                                    .padding(.top, 10)
    //                                .padding(.leading,-20)
                                
                                
                            }.frame(width:widthMenu == 375 ? 290 : 310, height : 300)
                                .onAppear{
                                    
                                    save.getMedicaments()
                                }.padding()
                        }
                    }.padding(.bottom,5)
                    
                    
                    Divider().background(Color("ButtonColor"))
                    
                    VStack{
                        Button("Enviar") {
                                                        
                            let newWR = WeekReport(followDiet : followDiet, saltConsumption : saltConsumption,
                                                    beveragesIntake : beveragesIntake, numBeverages : numBeverages,
                                                    physicalActivity : physicalActivity, numPhysicalActivity : numPhysicalActivity,
                                                    sleepHours : sleepHours, followMedicalPresciption : followMedicalPresciption,
                                                   reportDate : reportDate,  medicaments: save.meds)

                            let processResults = newWR.uploadWR()
                            
                            alertTitle = processResults.1
                            alertMessage =  processResults.2

                            weekReportSubmitted = true

                            if processResults.0 {
                                followDiet = 5.0
                                saltConsumption = 5.0
                                beveragesIntake = false
                                numBeverages = 0
                                physicalActivity = 5.0
                                numPhysicalActivity = 0
                                sleepHours = 0
                                followMedicalPresciption = true
                            }

                        }
                        .foregroundColor(Color("ButtonColor"))
                        .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("ButtonColor"), lineWidth: 1)
                        .frame(minWidth: 100,minHeight: 40))
                        .alert(alertTitle, isPresented: $weekReportSubmitted){
                            
                            Button("OK"){
                                //si se oprime quitar el ok
                            }
                        } message: {
                            Text(alertMessage)
                        }
                    }.padding()
                    
                }.padding(.init(top: 0, leading: 20, bottom: 350, trailing: 20))
            }.onTapGesture {
                hideKeyboard()
            }.ignoresSafeArea(.all)
        }
       
    }
}
