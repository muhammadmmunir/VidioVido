//
//  Content.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

struct Content {
    let id: Int
    let variant: String
    let items: [ContentItem]
    
    var isPortait: Bool {
        self.variant == "portrait" ? true : false
    }
}
