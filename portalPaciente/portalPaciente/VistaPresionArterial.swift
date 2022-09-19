//
//  VistaPresionArterial.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaPresionArterial: View {
    @EnvironmentObject var user: User
    
    @State var presion1 : String
    
    var body: some View {
        
        NavigationView {
            
            HStack {
                VStack {
                    Image("blood-pressure")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                    
                    
                    HStack {
                        Text("Presión 1: ")
                        TextField("presion1", text: $presion1)
                        Button("Guardar") {
                            self.user.presion1 = Int(presion1)
                        }
                    }
                    .scenePadding()
                    .padding()
                    
                }
                .padding()
                .frame(width: .infinity, height: 300, alignment: .top)
            }
            .frame(width: 400, height: 600, alignment: .top)
            .navigationTitle("Registro de presión arterial")
            .border(Color.red)
        }
    }
}

struct VistaPresionArterial_Previews: PreviewProvider {
    static var previews: some View {
        VistaPresionArterial(presion1: "")
    }
}

