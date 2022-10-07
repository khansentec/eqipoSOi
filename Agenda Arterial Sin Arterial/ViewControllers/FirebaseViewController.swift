//
//  FirebaseViewController.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import Foundation

class FirebaseViewController: ObservableObject{
    
    @Published var show = "Login"
    @Published var showApp = "Home"
    @Published var autfail = false
    @Published var data : Pacient!
    @Published var meds = [Medicament]()
    @Published var medUpdate : Medicament!
    @Published var reminds = [Remind]()
    @Published var remindUpdate : Remind!
    
    func sendMed(item: Medicament){
        medUpdate = item
    }
    
    func sendRemind(item: Remind){
        remindUpdate = item
    }

    
}

