//
//  ContentView.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/6/22.
//

import SwiftUI

struct ResultView: View {
    var choice : String
    
    var body: some View {
        Text("You chose \(choice)")
    }
}

class User: ObservableObject {
    @Published var presion1 : Int?
    @Published var presion2 : Int?
    @Published var presion3 : Int?
}

//struct ChangeView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        VStack {
//            Text("Score: \(user.score)")
//            Button("Increase") {
//                self.user.presion1 += 1
//            }
//        }
//    }
//}

struct ContentView: View {
    
    @State private var isShowingDetailView = false
    @State private var selection: String? = nil
    
    @StateObject var user = User()
    
    var body: some View {
        //        Text("Bienvenido")
        //            .fontWeight(.bold)
        //            .font(.largeTitle)
        //            .padding()
        //        Text("al portal de pacientes")
        //            .padding()
        //        Text("Por favor, elija una pagina para abrir.")
        //
        
        
        NavigationView {
            
            //            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            //
            //            ScrollView {
            //                LazyVGrid(columns: columns) {
            //                    ForEach(0x1f600...0x1f679, id: \.self) { value in
            //                        Text(String(format: "%x", value))
            //                        Text("Hi")
            //                            .font(.largeTitle)
            //                    }
            //                }
            //            }
            //
            VStack(spacing: 10) {
                VistaTablero(user: user)
            }
            .navigationTitle("Página central")
            .padding()
            .frame(minWidth: 10, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .background(Color("azulFondo"))

        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
        .previewDevice("iPhone 11")
    }
}

