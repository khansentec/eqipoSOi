//
//  FrecuentlyAskedQuestions.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI
struct FrecuentlyAskedQuestions: View {
    @State var questionList = [[String]]()
    @State private var index = "Preguntas Frecuentes"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    var body: some View {
        
        ZStack(alignment: .leading){
            VStack{
                NavBarHome(menu:$menu, index: $index).onTapGesture {
                    withAnimation{
                        menu = false
                    }
                }
                Text("Preguntas Frecuentes").bold().font(.title)
                VStack (alignment: .leading) {
                    
                    ForEach(questionList, id: \.self) {
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
                withAnimation{
                    menu = false
                }
                
            }
            if menu {
                NavBarMenu(index: index, menu: menu)
            }
        }
    }
}

