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

    @State var medicaments = [Medicament]()
    
    
    class MedicamentosViewModel : ObservableObject {
        @Published var medicamentos : [Medicament] = Medicament.medicamentosList
    }
    
    @StateObject fileprivate var viewModel = MedicamentosViewModel()
    
    var body: some View {
        VStack{
            Text("Reporte Semanal").font(.system(size: device == .pad ? 35: widthMenu == 375 ? 20 : 20)).bold()
            ScrollView{
                
                VStack {
                    DisclosureGroup("Alimentacion") {
                        VStack(spacing : 15){
                            Text("¿Has seguido con la dieta?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            Slider(value: $followDiet, in: 0...10, minimumValueLabel: Text("No").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)), maximumValueLabel: Text("Si").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))) { Text("") }.frame(width: device == .pad ? 350 : 300)
                            Text("\(followDiet, specifier:"%.1f")").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            Text("¿Como ha sido tu consumo de sal?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                .multilineTextAlignment(.center)
                            Slider(value: $saltConsumption, in: 0...10, minimumValueLabel: Text("Poco").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)), maximumValueLabel: Text("Mucho").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))) { Text("") }.frame(width: device == .pad ? 350 : 300)
                            Text("\(saltConsumption, specifier:"%.1f")")
                            HStack{
                                Text("¿Has consumido\nrefrescos?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                    .multilineTextAlignment(.leading)
                                
                                
                                Picker(selection: $beveragesIntake, label: Text("Picker")) {
                                    Text("Sí").tag(true)
                                    Text("No").tag(false)
                                }.frame(width : widthMenu == 375 ? 80 : 70, height: 10)
                                    .scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                                    .accentColor(Color("ButtonColor"))
                                    .padding(.top,-5)
                                    //.scaleEffect(1.75)
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                
                                
                            }.padding(.leading,-50)
                            HStack{
                                Text("Cantidad de refrescos: ").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))


                                TextField("Numero", value: $numBeverages, formatter: NumberFormatter())
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                                    .disabled(!beveragesIntake)
                            
                                
                            }
                        }.padding()
                        
                    }.padding(.bottom,5).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)).frame(width: device == .pad ? 650 : 350)
                    
                    Divider().background(Color("ButtonColor")).frame(width: device == .pad ? 650 : 350)
                    
                    DisclosureGroup("Ejercicio") {
                        VStack(spacing : 15){
                            Text("¿Cómo ha sido tu actividad física?").multilineTextAlignment(.center).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                            Slider(value: $physicalActivity, in: 0...10, minimumValueLabel: Text("Mala").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)), maximumValueLabel: Text("Buena").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))) { Text("") }.frame(width: 300)
                            Text("\(physicalActivity, specifier:"%.1f")")
                            Text("¿Cuántas veces te has ejercitado esta semana?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                .multilineTextAlignment(.center)

                            TextField("Numero", value: $numPhysicalActivity, formatter: NumberFormatter())
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }.padding()
                        
                    }.padding(.bottom,5).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)).frame(width: device == .pad ? 650 : 350)
                    
                    Divider().background(Color("ButtonColor")).frame(width: device == .pad ? 650 : 350)
                    
                    DisclosureGroup("Descanso") {
                        VStack{
                            Text("Durante esta semana,¿Cuántas horas dormiste en promedio al día ?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                .multilineTextAlignment(.center)
                                .frame(width: device == .pad ? 500 : 350)

                            TextField("Numero", value: $sleepHours, formatter: NumberFormatter())
                                    .frame(minWidth: 15, maxWidth: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .fixedSize()
                                    .keyboardType(.numberPad)
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                        }.padding()
                    }.padding(.bottom,5).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)).frame(width: device == .pad ? 650 : 350)
                    
                    Divider().background(Color("ButtonColor")).frame(width: device == .pad ? 650 : 350)
                    
                    DisclosureGroup("Medicamentos") {
                        VStack{
                            HStack{
                                Text("Durante esta semana, \n¿Ha cumplido con la receta?").font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                    .multilineTextAlignment(.leading)
                                Picker(selection: $followMedicalPresciption, label: Text("Picker")) {
                                    Text("Sí").tag(true)
                                    Text("No").tag(false)
                                }.frame(width : widthMenu == 375 ? 60 : 70, height: 10)
                                    .scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                                    .accentColor(Color("ButtonColor"))
                                    .padding(.top,-5)
                                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                
                            }.padding()
                            VStack(alignment: .center){
                                Text("Si indica 'No',¿Cuántas veces se te han olvidado tus medicamentos ?")
                                    .multilineTextAlignment(.center).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                                    .frame(width: device == .pad ? 500 : 350)
                            }.padding()
                            
                            List($medicaments){ $medicament in
                                VStack{
                                    VStack{
                                        Text(medicament.medicamentName)
                                            .multilineTextAlignment(.center)
                                        HStack{
                                            TextField("Numero", value: $medicament.forgetTimes, formatter: NumberFormatter())
                                                .frame(minWidth: 15, maxWidth: 50)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .fixedSize()
                                                .keyboardType(.numberPad)
                                                .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
      
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
                                    UITableView.appearance().backgroundColor = .clear
                                }.padding()
                        }
                    }.padding(.bottom,5).font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18)).frame(width: device == .pad ? 650 : 350)
                    
                    
                    Divider().background(Color("ButtonColor")).frame(width: device == .pad ? 650 : 350)
                    
                    VStack{
                        Button("Enviar") {
                            
                            var newWR = WeekReport(followDiet : followDiet, saltConsumption : saltConsumption,
                                                    beveragesIntake : beveragesIntake, numBeverages : numBeverages,
                                                    physicalActivity : physicalActivity, numPhysicalActivity : numPhysicalActivity,
                                                    sleepHours : sleepHours, followMedicalPresciption : followMedicalPresciption,
                                                    reportDate : reportDate,  medicaments: medicaments)

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
                        .frame(minWidth: device == .pad ? 150 :widthMenu == 375 ? 100 : 100, minHeight: device == .pad ?60 : widthMenu == 375 ? 40 : 40))
                        .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 16 : 16))
                        .alert(alertTitle, isPresented: $weekReportSubmitted){
                            
                            Button("OK"){
                                //si se oprime quitar el ok
                            }
                        } message: {
                            Text(alertMessage)
                        }
                    }.padding().frame(height: 100)
                    
                }.padding(.all)
            }.onTapGesture {
                hideKeyboard()
            }.ignoresSafeArea(.all)
        }
       
    }
}
