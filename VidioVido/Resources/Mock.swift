//
//  Mock.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

struct Mock {
    static let content = """
    [
      {
        "id": 1,
        "variant": "portrait",
        "items": [
          {
            "id": 1,
            "title": "title 1",
            "video_url": "https://vidio.com/watch/32442.m3u8",
            "image_url": "https://www.siarandepok.com/data/uploads/2019/03/5-1-1.jpg"
          },
          {
            "id": 2,
            "title": "title 2",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://www.siarandepok.com/data/uploads/2019/03/5-1-1.jpg"
          },
          {
            "id": 3,
            "title": "title 3",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://www.siarandepok.com/data/uploads/2019/03/5-1-1.jpg"
          }
        ]
      },
      {
        "id": 2,
        "variant": "landscape",
        "items": [
          {
            "id": 1,
            "title": "title 1",
            "video_url": "https://vidio.com/watch/32442.m3u8",
            "image_url": "https://w0.peakpx.com/wallpaper/156/622/HD-wallpaper-avengers-endgame-all-characters-superheroes-movies.jpg"
          },
          {
            "id": 2,
            "title": "title 2",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://w0.peakpx.com/wallpaper/156/622/HD-wallpaper-avengers-endgame-all-characters-superheroes-movies.jpg"
          },
          {
            "id": 3,
            "title": "title 3",
            "video_url": "https://vidio.com/watch/32443.m3u8",
            "image_url": "https://w0.peakpx.com/wallpaper/156/622/HD-wallpaper-avengers-endgame-all-characters-superheroes-movies.jpg"
          }
        ]
      }
    ]
    """.data(using: .utf8)
}

