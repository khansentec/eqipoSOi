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
            }
            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(.trailing, 5)
                    .frame(width : 5)
                Text("Eliminar")
                    .foregroundColor(.red)
                    .padding(.top, 3.5)
                
            })
        }
        
        .padding(.bottom, 100).border(.black)
    }
}
