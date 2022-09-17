//
//  PresionImagen.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct PresionImagen: View {
    var body: some View {
        Image("blood-pressure")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct PresionImagen_Previews: PreviewProvider {
    static var previews: some View {
        PresionImagen()
    }
}

