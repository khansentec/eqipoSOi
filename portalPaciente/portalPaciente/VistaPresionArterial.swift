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
            
            //            Text("Por favor, seleccione una página para abrir")
            //                .frame(alignment: .topLeading)
            //                .navigationBarTitle("Presión arterial", displayMode: .inline)
            //
            HStack (alignment: .top){
                VStack {
                    Image("blood-pressure")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                    
                    Spacer()
                                        
                    HStack {
                        Text("Presión 1: ")
                        TextField("presion1", text: $presion1)
                        Button("Guardar") {
                            self.user.presion1 = Int(presion1)
                        }
                    }
                    .scenePadding()
                    
                }
                .padding()
                .frame(width: .infinity, height: 350, alignment: .top)
                
            }
            .ignoresSafeArea(edges: .top)
            .border(Color.red)
        }
    }
}

struct VistaPresionArterial_Previews: PreviewProvider {
    static var previews: some View {
        VistaPresionArterial(presion1: "")
    }
}

