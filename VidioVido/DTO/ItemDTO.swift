//
//  ItemDTO.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

struct ItemDTO: Codable {
    let id: Int
    let title: String
    let videoUrl: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case videoUrl = "video_url"
        case imageUrl = "image_url"
    }
}

extension ItemDTO {
    func toEntity() -> ContentItem {
        return .init(
            id: self.id,
            title: self.title,
            videoUrl: self.videoUrl ?? "",
            imageUrl: self.imageUrl ?? ""
        )
    }
}
