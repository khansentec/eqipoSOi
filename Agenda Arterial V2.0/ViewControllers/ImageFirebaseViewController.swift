//
//  ImageFirebaseViewController.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 22/09/22.
//

import Foundation
import Firebase
import FirebaseStorage

class ImageFirebaseViewController : ObservableObject{
    
    @Published var data : Data? = nil
    
    init(imageUrl : String){
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1*1024*1024){
            (data, error) in
            if let error = error?.localizedDescription {
                print("Error getting the image ", error)
            }else{
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
    
    
}
