//
//  MedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct ReminderView: View {
    
    @State private var screenWidth = UIScreen.main.bounds.width
    
    @State var reminder : Remind
    @State var date = ""
    
    @StateObject var controller = FirebaseViewController()
    
    var body: some View {
        VStack (alignment: .leading){
            HStack (spacing: 5) {
                VStack(alignment:.leading, spacing : 5){
                    Text(date)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                    
                    HStack {
                        Text(reminder.title)
                            .padding(.leading, 20)
                            .lineLimit(1)
                    }
                }.onAppear{
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .short
                    date = formatter1.string(from: reminder.date)
                }
                
                
            }
            .frame(minWidth: screenWidth-100, minHeight: 70)
            .padding(10)
            
            Spacer()
        }
        .aspectRatio(contentMode: .fit)
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: screenWidth-50, minHeight: 70)
        .overlay(RoundedRectangle(cornerRadius: 20).fill(reminder.type == "reporteSalud" ? .green.opacity(0.2) : reminder.type == "reporteSemanal" ? .orange.opacity(0.2) : reminder.type == "medicion" ? .red.opacity(0.2) : reminder.type == "consulta" ? Color("WeekColor").opacity(0.2) : .gray.opacity(0.2)).shadow(radius: 3))
    }
}







