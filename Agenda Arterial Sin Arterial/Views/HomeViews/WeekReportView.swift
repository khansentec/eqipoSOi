//
//  WeekReportView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 20/09/22.
//

import SwiftUI

struct WeekReportView: View {
    @State var seguimientoDieta = 5.0
    @State var consumoSal = 5.0
    @State var consumoRefrescos = false
    @State var cantidadRefrescos = 0
    @State var actividadFisica = 5.0
    @State var numActividadFisica = 0
    @State var horasDescanso = 0
    @State var seguimientoReceta = true
    @State var fechaReporte = Date.now
    var fechaSigReporte = Calendar.current.date(byAdding: DateComponents(day: 7), to: Date.now)
    
    @State var alerta = false
    @State var mensajeAlerta = ""
    
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var showNavbar = true
    
    class MedicamentosViewModel : ObservableObject {
        @Published var medicamentos : [Medicament] = Medicament.medicamentosList
    }
    
    @StateObject fileprivate var viewModel = MedicamentosViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if showNavbar{
                    NavBarViews()
                }
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            DisclosureGroup("Alimentacion") {
                                VStack(spacing : 15){
                                    Text("¿Has seguido con la dieta?")
                                    Slider(value: $seguimientoDieta, in: 0...10, minimumValueLabel: Text("No"), maximumValueLabel: Text("Si")) { Text("") }.frame(width: 200)
                                    Text("\(seguimientoDieta, specifier:"%.1f")")
                                    Text("¿Como ha sido tu consumo de sal?")
                                        .multilineTextAlignment(.center)
                                    Slider(value: $consumoSal, in: 0...10, minimumValueLabel: Text("Poco").font(.system(size: 14)), maximumValueLabel: Text("Mucho").font(.system(size: 14))) { Text("") }.frame(width: 230)
                                    Text("\(consumoSal, specifier:"%.1f")")
                                    HStack{
                                        Text("¿Has consumido\nrefrescos?")
                                            .multilineTextAlignment(.leading)
                                        
                                        Picker(selection: $consumoRefrescos, label: Text("Picker")) {
                                            Text("Sí").tag(true)
                                            Text("No").tag(false)
                                        }.frame(width : widthMenu == 375 ? 80 : 70, height: 10)
                                            .accentColor(.blue)
                                            .padding(.top,-5)
                                    }.padding(.leading,-50)
                                    HStack{
                                        Text("Cantidad de refrescos: ")
                                            .multilineTextAlignment(.leading)
                                            .font(.system(size: 13))
                                        
                                        TextField("Numero", value: $cantidadRefrescos, formatter: NumberFormatter())
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .frame(minWidth: 15, maxWidth: 40)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .disabled(true)
                                        Stepper("Value", value: $cantidadRefrescos, in: 0...100)
                                            .labelsHidden()
                                    }
                                }.padding()
                                
                            }.padding(.bottom,5)
                            
                            Divider().background(Color.blue)
                            
                            DisclosureGroup("Ejercicio") {
                                VStack(spacing : 15){
                                    Text("¿Cómo ha sido tu actividad física?").multilineTextAlignment(.center)
                                    
                                    Slider(value: $actividadFisica, in: 0...10, minimumValueLabel: Text("Mala"), maximumValueLabel: Text("Buena")) { Text("") }
                                    Text("\(actividadFisica, specifier:"%.1f")")
                                    Text("¿Cuántas veces te has ejercitado esta semana?")
                                        .multilineTextAlignment(.center)
                                    HStack{
                                        TextField("Numero", value: $numActividadFisica, formatter: NumberFormatter())
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .frame(minWidth: 15, maxWidth: 50)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .disabled(true)
                                        Stepper("Value", value: $numActividadFisica, in: 0...100)
                                            .labelsHidden()
                                    }
                                }.padding()
                                
                            }.padding(.bottom,5)
                            
                            Divider().background(Color.blue)
                            
                            DisclosureGroup("Descanso") {
                                VStack{
                                    Text("Durante esta semana,¿Cuántas horas dormiste en promedio al día ?")
                                        .multilineTextAlignment(.center)
                                    HStack{
                                        TextField("Numero", value: $horasDescanso, formatter: NumberFormatter())
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .frame(minWidth: 15, maxWidth: 50)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .disabled(true)
                                        Stepper("Value", value: $horasDescanso, in: 0...24)
                                            .labelsHidden()
                                    }
                                }.padding()
                            }.padding(.bottom,5)
                            
                            Divider().background(Color.blue)
                            
                            DisclosureGroup("Medicamentos") {
                                VStack{
                                    HStack{
                                        Text("Durante esta semana, \n¿Ha cumplido con la receta?")
                                            .multilineTextAlignment(.leading)
                                        Picker(selection: $seguimientoReceta, label: Text("Picker")) {
                                            Text("Sí").tag(true)
                                            Text("No").tag(false)
                                        }.frame(width : widthMenu == 375 ? 60 : 70, height: 10)
                                            .accentColor(.blue)
                                            .padding(.top,-5)
                                        
                                    }.padding()
                                    VStack(alignment: .center){
                                        Text("Si indica 'No',¿Cuántas veces se te han olvidado tus medicamentos ?")
                                            .multilineTextAlignment(.center)
                                    }.padding()
                                    
                                    List($viewModel.medicamentos){ $medicamento in
                                        VStack{
                                            VStack{
                                                Text(medicamento.nombreMedicamento)
                                                HStack{
                                                    TextField("Numero", value: $medicamento.vecesOlvidado, formatter: NumberFormatter())
                                                        .multilineTextAlignment(.center)
                                                        .keyboardType(.decimalPad)
                                                        .frame(minWidth: 15)
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .disabled(true)
                                                    Stepper("Value", value: $medicamento.vecesOlvidado, in: 0...100)
                                                        .labelsHidden()
                                                }
                                            }.padding(.all, 10)
                                            
                                        }.frame(width: widthMenu == 375 ? 250 : 270)
                                            .overlay(RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.cyan, lineWidth: 1))
                                            .listRowSeparator(.hidden)
                                            .padding(.top, 10)
                                        //                                .padding(.leading,-20)
                                        
                                        
                                    }.frame(width:widthMenu == 375 ? 290 : 310, height : 300)
                                        .onAppear{
                                            UITableView.appearance().backgroundColor = .clear
                                        }.padding()
                                }
                            }.padding(.bottom,5)
                            
                            
                            Divider().background(Color.blue)
                            
                            VStack{
                                Button("Enviar") {
                                    print(seguimientoDieta)
                                    print(consumoSal)
                                    print(consumoRefrescos)
                                    print(cantidadRefrescos)
                                    print(actividadFisica)
                                    print(numActividadFisica)
                                    print(horasDescanso)
                                    print(seguimientoReceta)
                                    for medicamento in viewModel.medicamentos {
                                        print("\(medicamento.nombreMedicamento) : \(medicamento.vecesOlvidado)")
                                    }
                                    print("Fecha reporte actual :", fechaReporte)
                                    print("Fecha sig :", fechaSigReporte!)
                                    
                                }.alert("Error", isPresented: $alerta){
                                    
                                    Button("OK"){
                                        //si se oprime quitar el ok
                                    }
                                } message: {
                                    Text(mensajeAlerta)
                                }
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("ButtonColor"))
                                    .frame(minWidth: 100,minHeight: 40))
                           
                            }.padding()
                            
                        }
                        .navigationBarTitle("Reporte semanal", displayMode: .inline)
                        .padding(.all,30)
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }
    
}

