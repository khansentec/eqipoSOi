//
//  ImageFirebase.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct ImageFirebase: View {
    let imagenAlternativa = UIImage(systemName: "photo")
    @ObservedObject var imageLoader : ImageFirebaseViewController
    
    init(imageUrl : String){
        imageLoader = ImageFirebaseViewController(imageUrl: imageUrl)
    }
    
    var image : UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    
    var body: some View {
        Image(uiImage: image ?? imagenAlternativa!).resizable().frame(width: 125, height: 125).cornerRadius(15).clipShape(Circle())
    }
}

