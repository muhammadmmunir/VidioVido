//
//  ContentDTO.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

struct ContentDTO: Codable {
    let id: Int
    let variant: String
    let items: [ItemDTO]
}

extension ContentDTO {
    func toEntity() -> Content {
        return .init(
            id: self.id,
            variant: self.variant,
            items: self.items.map { $0.toEntity() }
        )
    }
}

extension Array where Element == ContentDTO {
    func toEntity() -> [Content] {
        return self.map { $0.toEntity() }
    }
}
