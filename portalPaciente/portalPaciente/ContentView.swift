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
    @Published var score = 0
}

struct ChangeView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("Score: \(user.score)")
            Button("Increase") {
                self.user.score += 1
            }
        }
    }
}

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
                Text("Por favor, seleccione una página para abrir")
                    .frame(alignment: .topLeading)
                    .navigationBarTitle("Página central", displayMode: .inline)
                NavigationLink(destination: Text("Entre una medición para agregar: "), tag: "Medicion", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("Elija un doctor: "), tag: "Doctor", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("Vista 3"), tag: "Vista 3", selection: $selection) { EmptyView() }
                VStack {
                    HStack {
                        Button("Agrega medición") {
                            self.selection = "Medicion"
                        }
                        .frame(width: 160, height: 100)
                        .border(Color.black)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Rectangle())
                        .aspectRatio(contentMode: .fit)
                        
                        
                        Button("Platicar con doctor") {
                            self.selection = "Doctor"
                        }
                        .frame(width: 160, height: 100)
                        .border(Color.black)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Rectangle())
                        
                        
                    }
                    
                    HStack{
                        Button("Muestra vista 3") {
                            self.selection = "Doctor"
                        }
                        .frame(width: 160, height: 100)
                        .border(Color.black)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Rectangle())
                        
                        Button("Muestra vista 4") {
                            self.selection = "Doctor"
                        }
                        .frame(width: 160, height: 100)
                        .border(Color.black)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Rectangle())
                    }
                }
                
                
                Text("ChangeView score: \(user.score)")
                NavigationLink(destination: ChangeView()) {
                    Text("Show Detail View")
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
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


