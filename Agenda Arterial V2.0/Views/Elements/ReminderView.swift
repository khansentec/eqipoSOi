//
//  ReminderView.swift
//  Agenda Arterial V2.0
//
//  Created by Katie Hansen on 10/2/22.
//
import SwiftUI

struct ReminderView: View {
    
    @State var reminder : Remind
    @State var date = ""
    
    var body: some View {
        HStack{
            VStack(alignment:.leading, spacing : 5){
               
                Text(date)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                Text(reminder.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
            }.onAppear{
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                date = formatter1.string(from: reminder.date)
            }
            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(.trailing, 5)
                    .frame(width : 5)
                
            })
        }
        
        .padding(.bottom, 100).border(.black)
    }
}
