//
//  AddMedicView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct AddMedicView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var linkCode : [Int]
    @Environment(\.horizontalSizeClass) var width
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var controller = FirebaseViewController()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Vincular aquí").foregroundColor(Color("Text"))
            Spacer().frame(maxHeight: 10)
            Text("Por código del paciente:").foregroundColor(Color("Text"))
            HStack{
                ForEach(linkCode,id: \.self){
                    number in
                    Text(String(number)).font(.custom("Helvetica", size: 50)).foregroundColor(Color("Text")).frame(width: 60, height: 60).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 2)
                    )
                    .fixedSize()
                }
            }
            Spacer().frame(minHeight: widthMenu == 375 ? 200 : 300, maxHeight: widthMenu == 375 ? 400 : 500)
        }.onDisappear{
            controller.deleteLinkCode(){
                (done)in
                if done{
                    print("Delete linkcode")
                }else{
                    print("Error")
                }
            }
        }
    }
}
