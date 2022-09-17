//
//  VistaRegistrar.swift
//  portalPaciente
//
//  Created by Katie Hansen on 9/17/22.
//

import SwiftUI

struct VistaRegistrar: View {

    var body: some View {
        
        var nombre : String = ""
        var apellidos : String = ""
        var correo : String = ""
        var fechaDeNac : String = ""
        var doctorVinculado : String! = nil
        var contrasena : String = ""
        
        Text("Por favor provea la siguiente información para crear una cuenta.")
        Text("Nombre: ")
        Text("Appelido(s): ")
        Text("Correo electrónico: ")
        Text("Fecha de nacimiento: ")
        Text("Doctor vinculado: ")
        Text("Contraseña: ")
    }
}

struct VistaRegistrar_Previews: PreviewProvider {
    static var previews: some View {
        VistaRegistrar()
    }
}

