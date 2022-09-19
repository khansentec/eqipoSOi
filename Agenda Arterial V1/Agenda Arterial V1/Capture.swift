//
//  Capture.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Capture {
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
