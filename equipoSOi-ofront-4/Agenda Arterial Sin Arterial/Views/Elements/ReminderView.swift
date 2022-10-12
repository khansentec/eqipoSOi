//
//  ReminderView.swift
//  Agenda Arterial V2.0
//
//  Created by Katie Hansen on 10/2/22.
//
import SwiftUI

struct ReminderView: View {
    
    @State var reminder : Remind
    
    var body: some View {
        HStack{
            VStack(alignment:.leading, spacing : 5){
                Text(reminder.date)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                
                ForEach(reminder.events, id: \.self) {
                    evento in
                    HStack {
                        Text(evento)
                            .padding(.leading, 20)
                            .lineLimit(1)
                    }
                }
            }.frame(width: 350  ,height: 350 )
            
            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                //Espacio entre la imagen y el texto
                    .padding(.trailing, 10)
                    .frame(width : 5)
                Text("Eliminar")
                    .foregroundColor(.red)
                    .padding(.top, 3.5).padding(.all)
                //Agregar espacio entre el texto y el borde con un trailing 
                
                
            })
        }.overlay(RoundedRectangle(cornerRadius: 20).stroke( Color.gray,lineWidth: 1).shadow(radius: 3))
        
        .padding(.bottom, 100)//.border(.black)
    }
}
