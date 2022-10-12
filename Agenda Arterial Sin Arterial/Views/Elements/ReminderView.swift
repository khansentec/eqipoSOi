//
//  MedicamentView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct ReminderView: View {
    
    @State private var screenWidth = UIScreen.main.bounds.width
    
    var reminder : Remind
    
    var body: some View {
        VStack (alignment: .leading){
            HStack (spacing: 5) {
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
                
                Spacer()
                
            }
            .frame(minWidth: screenWidth-100, minHeight: 70)
            .padding(10)
            
            Spacer()
        }
        .aspectRatio(contentMode: .fit)
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: screenWidth-50, minHeight: 70)
        .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)).shadow(radius: 3))
    }
}







