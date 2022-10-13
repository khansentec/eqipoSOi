//
//  HealthStateView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct HealthStateView: View {
    @State var rest = ""
    @State var feeling = ""
    @State var comments = ""
    @State var syptoms = false
    @State private var speed = 5.0
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack{
            VStack{
                Text("Estado de Salud").font(.system(size: device == .pad ? 35: widthMenu == 375 ? 20 : 20)).bold()
                VStack (alignment: .leading) {
                    VStack (alignment: .leading){
                        HStack {
                            Text("Sentimiento del día: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                            Text("\(speed, specifier:"%.1f")").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        }
                        Slider(
                            value: $speed,
                            in: 0...10,
                            minimumValueLabel: Text("Mal").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18)),
                            maximumValueLabel: Text("Bien").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        ) { Text("efhao") }
                    }
                    .padding()
                    
                    HStack{
                        Text("¿Ha tenido síntomas?").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                            .multilineTextAlignment(.leading)
                        
                        Picker(selection: $syptoms, label: Text("Picker")) {
                            Text("Sí").tag(true)
                            Text("No").tag(false)
                        }
                        .frame(width : 70, height: 10).scaledToFit().scaleEffect(CGSize(width: 1.5 ,height: 1.5))
                        .accentColor(Color("ButtonColor"))
                        .padding(.top,-5)
                        .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                    }
                    .padding()
                    
                    VStack (alignment: .leading) {
                        Text("Síntomas nuevas: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        HStack {
                            TextEditor(text: $feeling)
                                .frame(maxHeight: 100, alignment: .center)
                                .disabled(!syptoms)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                    }
                    .scenePadding()
                    
                    VStack (alignment: .leading) {
                        Text("Otros comentarios: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        HStack{
                            TextEditor(text: $comments)
                                .frame(maxHeight: 240, alignment: .center)
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)).frame(alignment: .center)
                        
                    }
                    .padding(.all)
                    
                    
                    Spacer()
                    //.frame(width: device == .pad ? 900 : 350)
                    //.frame(width: device == .phone ? 300 : widthMenu == 1024 ? 900 : 700 )
                }.frame(width: device == .phone ? 350 : widthMenu == 1024 ? 900 : 700 )
            }
        }
    }
}
