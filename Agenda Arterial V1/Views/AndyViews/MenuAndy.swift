//
//  MenuAndy.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import SwiftUI

struct MenuAndy: View {
    var body: some View {
            NavigationView{
                ScrollView{
                    VStack{
                        HStack(spacing : 10){
                            NavigationLink(destination: Login()){
                                Text("Captura tu Presion")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                            NavigationLink(destination: Login()){
                                Text("Tus Medicamentos")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                        HStack(spacing : 10){
                            NavigationLink(destination: Login()){
                                Text("Reporte Semanal")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                            NavigationLink(destination: Login()){
                                Text("Tu Estado de Salud")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                        HStack(spacing : 10){
                            NavigationLink(destination: Login()){
                                Text("Calendario")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                            NavigationLink(destination: Login()){
                                Text("Estadisticas Semanales")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 145, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                        HStack(spacing : 10){
                            NavigationLink(destination: Login()){
                                Text("Medico Vinculado")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 270, height: 75)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(.blue).shadow(radius: 3))
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }
                    
                }
                
            }
        }

}
