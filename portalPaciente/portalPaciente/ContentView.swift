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

struct ContentView: View {
    @State private var isShowingDetailView = false
    @State private var selection: String? = nil
    
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
            VStack(spacing: 10) {
                Text("Por favor, seleccione una página para abrir")
                    .frame(alignment: .topLeading)
                    .navigationBarTitle("Página central", displayMode: .inline)
                NavigationLink(destination: Text("Entre una medición para agregar: "), tag: "Medicion", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("Elija un doctor: "), tag: "Doctor", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("Vista 3"), tag: "Vista 3", selection: $selection) { EmptyView() }
                
                Button("Agrega medición") {
                    self.selection = "Medicion"
                }
                Button("Platicar con doctor") {
                    self.selection = "Doctor"
                }
                Button("Muestra vista 3") {
                    self.selection = "Vista 3"
                }
                
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                .border(Color.red)
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
    }
}

