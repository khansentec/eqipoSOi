//
//  FrecuentlyAskedCuestionsView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 21/09/22.
//

import SwiftUI

struct FrecuentlyAskedCuestionsView: View {
    @State var listaPreguntas = [[String]]()
    @State private var index = "Preguntas Frecuentes"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    var body: some View {
        
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu:$menu).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                Text("Preguntas Frecuentes").bold().font(.title)
                VStack (alignment: .leading) {
                    
                    ForEach(listaPreguntas, id: \.self) {
                        pregunta in
                        VStack (alignment: .leading, spacing: 10){
                            Text(pregunta[0])
                                .fontWeight(.bold)
                            Text(pregunta[1])
                        }
                        .padding()
                        Divider()
                    }
                    
                    Spacer()
                }
            }.onTapGesture {
                menu = false
            }
            if menu{
                NavBarMenu(index: "Preguntas Frecuentes", menu: false)
            }
        }
    }
}
