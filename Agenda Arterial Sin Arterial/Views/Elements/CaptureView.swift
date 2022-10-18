//
//  CaptureView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 17/10/22.
//

import SwiftUI

struct CaptureView: View {
    @State private var screenWidth = UIScreen.main.bounds.width
    
    @State var record : MeditionRecord
    @State var date = ""
    
    @StateObject var controller = FirebaseViewController()
    
    var body: some View {
        VStack (alignment: .leading){
            HStack (spacing: 20) {
                VStack(alignment:.leading, spacing : 5){
                    HStack{
                        Text(date)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor"))
                        Text(record.date, style: .time)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9).foregroundColor(Color("ButtonColor")).padding(.trailing,5)
                    }
                    VStack (alignment: .leading){
                        HStack{
                            Text("Presion superoior: ").bold()
                            Text(String(record.pressureSup))
                                .padding(.leading, 2)
                                .lineLimit(1)
                        }
                        HStack{
                            Text("Presion inferior: ").bold()
                            Text(String(record.pressureInf))
                                .padding(.leading, 2)
                                .lineLimit(1)
                        }
                        HStack{
                            Text("Pulso: ").bold()
                            Text(String(record.pulse))
                                .padding(.leading, 2)
                            .lineLimit(1)
                        }
                    }
                    
                }.onAppear{
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .short
                    date = formatter1.string(from: record.date)
                }
                
                
            }
            .frame(minWidth: screenWidth-100, minHeight: 70)
            .padding(.top, 20)
            
            Spacer()
        }
        .aspectRatio(contentMode: .fit)
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: screenWidth-190, minHeight: 130)
        .overlay(RoundedRectangle(cornerRadius: 20).fill(record.state == "bien" ? .green.opacity(0.2) : record.state == "regular" ? .yellow.opacity(0.2) : record.state == "mal" ? .red.opacity(0.2) :  .gray.opacity(0.2)).shadow(radius: 3))
    }
}
