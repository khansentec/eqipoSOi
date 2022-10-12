//
//  MedicamentDetailsView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct MedicamentDetailsView: View {
    @State var editing = false
    @State var startDate : Date
    @State var medicament : Medicament
    @State var info : String
    
    @Binding var showNabar : Bool
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var widthMenu = UIScreen.main.bounds.width
    
    
    var body : some View {
        VStack(alignment : .trailing){
            VStack{
                Button(action: {
                    if editing {
                        editing = false
                    }else{
                        editing = true
                    }
                }, label: {
                    Image(systemName: editing ? "square.and.arrow.down": "square.and.pencil")
                        .resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                        .padding(.trailing, 5)
                        .frame(width : 10)
                    Text(editing ? "Guadar" : "Editar")
                        .foregroundColor(.blue)
                        .padding(.top, 3.5)
                        .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                    
                })
            }.padding(.trailing,60).padding(.top,0)
            
            VStack(alignment : .leading, spacing : 20){
                Text(medicament.medicamentName)
                    .font(.system(size: device == .pad ? 30: widthMenu == 375 ? 18 : 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider().frame(width : 250)
                HStack{
                    Text("Fecha de inicio: ").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                    DatePicker("", selection: $startDate, displayedComponents : .date)
                        .padding(.trailing,70).disabled(!editing)
                        .scaledToFit().scaleEffect(CGSize(width: 1.25 ,height: 1.25))
                }
                HStack{
                    TextEditor(text: $info)
                        .font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        .frame(maxWidth: widthMenu == 375 ? 270 : 270, maxHeight: 300, alignment: .leading)
                    
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(editing ? Color.gray : Color.clear, lineWidth: 1))
                    .disabled(!editing)
                
            }.padding(.leading, 60)
            
            VStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25)
                        .foregroundColor(.red)
                        .padding(.trailing, 5)
                        .frame(width : 10)
                    Text("Eliminar").font(.system(size: device == .pad ? 28: widthMenu == 375 ? 18 : 18))
                        .foregroundColor(.red)
                        .padding(.top, 3.5)
                    
                })
            }.padding(.trailing,60).padding(.top,10)
                
            
//            Spacer().frame(maxHeight: widthMenu == 375 ? 170 : 150)
        }.onTapGesture {
            hideKeyboard()
        }
        
        .padding(.top,0).onAppear{
            showNabar = false
        }.onDisappear{
            withAnimation{
                showNabar = true
            }
            
        }
        
    }
}

