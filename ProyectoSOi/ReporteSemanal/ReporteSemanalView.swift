//
//  ReporteSemanalView.swift
//  ProyectoSOi
//
//  Created by alumno on 19/09/22.
//

import SwiftUI

struct ReporteSemanalView: View {
    @State var seguimientoDieta = 5.0
    @State var consumoSal = 5.0
    @State var consumoRefrescos = false
    @State var cantidadRefrescos = 0
    @State var actividadFisica = 5.0
    @State var numActividadFisica = 0
    @State var tiempoActividadFisica = 0
    @State var horasDescanso = 0
    @State var seguimientoReceta = true
    @State var fechaReporte = Date.now
    var fechaSigReporte = Calendar.current.date(byAdding: DateComponents(day: 7), to: Date.now)
    @State var alerta = false
    @State var mensajeAlerta = ""
    
    
    class MedicamentosViewModel : ObservableObject {
        @Published var medicamentos : [Medicamento] = Medicamento.medicamentosList
    }
    
    @StateObject fileprivate var viewModel = MedicamentosViewModel()
    
    
    
    var body: some View {
        ScrollView{
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
                            }.frame(width : 40, height: 10)
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
                
                Divider().background(Color.cyan)
                
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
                        HStack{
                            Text("Tiempo por sesión: ")
                                .multilineTextAlignment(.leading)
                            TextField("Tiempo", value: $tiempoActividadFisica, formatter: NumberFormatter())
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                                .frame(minWidth: 15, maxWidth: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    
                    }.padding()
                    
                }.padding(.bottom,5)
                
                Divider().background(Color.cyan)
                
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
                
                Divider().background(Color.cyan)
                
                DisclosureGroup("Medicamentos") {
                    VStack{
                        HStack{
                            Text("Durante esta semana, \n¿Ha cumplido con la receta?")
                                .multilineTextAlignment(.leading)
                            Picker(selection: $seguimientoReceta, label: Text("Picker")) {
                                Text("Sí").tag(true)
                                Text("No").tag(false)
                            }.frame(width : 40, height: 10)
                                .accentColor(.blue)
                                .padding(.top,-5)
                        }
                        
                        List($viewModel.medicamentos){ $medicamento in
                            VStack{
                                VStack{
                                    Text(medicamento.nombreMedicamento)
                                    HStack{
                                        TextField("Numero", value: $medicamento.vecesOlvidado, formatter: NumberFormatter())
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.decimalPad)
                                            .frame(minWidth: 15, maxWidth: 40)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .disabled(true)
                                        Stepper("Value", value: $medicamento.vecesOlvidado, in: 0...100)
                                            .labelsHidden()
                                    }
                                }.padding(.all, 10)
                                
                            }.frame(width: 200)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cyan, lineWidth: 1))
                                .listRowSeparator(.hidden)
                                .padding(.top, 10)
                                .padding(.leading,-20)
                                
                            
                        }.frame(width: 225, height : 300)
                            .onAppear{
                                UITableView.appearance().backgroundColor = .clear
                            }.padding()
                    }
                }.padding(.bottom,5)
                
                
                Divider().background(Color.cyan)
                
                VStack{
                    Button("Enviar") {
                        if tiempoActividadFisica < 0  {
                            alerta = true
                            mensajeAlerta = "El tiempo por sesion tiene que ser mayor o igual a 0"
                        } else {
                            print(seguimientoDieta)
                            print(consumoSal)
                            print(consumoRefrescos)
                            print(cantidadRefrescos)
                            print(actividadFisica)
                            print(numActividadFisica)
                            print(tiempoActividadFisica)
                            print(horasDescanso)
                            print(seguimientoReceta)
                            for medicamento in viewModel.medicamentos {
                                print("\(medicamento.nombreMedicamento) : \(medicamento.vecesOlvidado)")
                            }
                            print("Fecha reporte actual :", fechaReporte)
                            print("Fecha sig :", fechaSigReporte!)
                            
                            
                        }
                        
                    }.alert("Error", isPresented: $alerta){
                        
                        Button("OK"){
                            //si se oprime quitar el ok
                        }
                    } message: {
                        Text(mensajeAlerta)
                    }
                    .foregroundColor(.red)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.red, lineWidth: 1)
                        .frame(minWidth: 100,minHeight: 40))
                    
                }.padding()
                
            }.padding(.all,30)
        }
    }
}



