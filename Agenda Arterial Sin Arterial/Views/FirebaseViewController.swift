//
//  FirebaseViewController.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 17/09/22.
//

import Foundation

class FirebaseViewController: ObservableObject{
    
    @Published var show = "Login"
    @Published var autfail = false
    @Published var data = [FirebaseViewController]()
    @Published var itemUpdate : FirebaseViewController!
    @Published var showEditing = false
   
}

