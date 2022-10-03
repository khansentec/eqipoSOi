//
//  ReminderView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Katie Hansen on 10/2/22.
//

import SwiftUI

struct ReminderView: View {
    
    @State var reminder : Remind
    
    var body: some View {
        VStack(alignment:.leading, spacing : 5){
            Text(reminder.fecha)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.9).foregroundColor(.blue)
            
            ForEach(reminder.eventos, id: \.self) {
                evento in
                HStack {
                    Text(evento)
                        .padding(.leading, 20)
                        .lineLimit(1)
                }
            }
        }
        .padding(.bottom, 100)
    }
}

