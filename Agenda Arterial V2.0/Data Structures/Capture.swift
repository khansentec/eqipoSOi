//
//  Capture.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 18/09/22.
//

import Foundation

class Capture {
    var presion : (Int, Int)
    var pulse : Int
    
    init(presionSup : Int, presionInf : Int, pulse : Int){
        self.idCapture = ""
        self.presion = (presionSup, presionInf)
        self.pulse = pulse
    }
    
    var description : String {
        return "\(self.presion) \(self.pulse)"
    }
}
