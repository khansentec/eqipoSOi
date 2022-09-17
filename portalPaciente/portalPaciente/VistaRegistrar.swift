//
//  VistaRegistrar.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/15/22.
//

import Foundation
import SwiftUI

struct VistaRegistrar: View {
    
    var nombre : String
    var apellidos : String
    var correo : String
    var fechaDeNac : String
    var doctorVinculado : String!
    var contrasena : String
    
    var body: some View {
        Text("Por favor provea la siguiente información para crear una cuenta.")
        Text("Nombre: ")
        Text("Appelido(s): ")
        Text("Correo electrónico: ")
        Text("Fecha de nacimiento: ")
        Text("Doctor vinculado: ")
        Text("Contraseña: ")
    }
}

