//
//  Captura.swift
//  Class
//
//  Created by alumno on 06/09/22.
//

import Foundation

class Captura {
    var idCaptura : String
    var presion : (Int, Int)
    var pulso : Int
    
    init(presionSup : Int, presionInf : Int, pulso : Int){
        self.idCaptura = ""
        self.presion = (presionSup, presionInf)
        self.pulso = pulso
    }
    
    var description : String {
        return "\(self.presion) \(self.pulso)"
    }
}


