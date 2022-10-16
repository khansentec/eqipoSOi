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
                VStack (alignment: .center) {
                    Text("Preguntas Frecuentes").bold().font(.title)
                    
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
                    VStack (alignment: .leading, spacing: 10){
                        Text("P: ¿Como tomarme la Presión Arterial?").fontWeight(.bold)
                        Link("Ve cómo tomar la presión arterial", destination: URL(string: "https://www.facebook.com/CentroMedicoABC/videos/aprende-a-tomar-la-presi%C3%B3n-arterial-correctamente/953165865261484/")!)
                    }
                    .padding()
                    Divider()
                    Spacer()
                }
                .padding(30)
            }
            
            if menu {
                NavBarMenu(index: $index, menu: $menu)
            }
        }
        .onTapGesture {
            withAnimation{
                menu = false
            }
            hideKeyboard()
        }
    }
}

