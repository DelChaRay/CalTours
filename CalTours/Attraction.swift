//
//  Attraction.swift
//  CalTours
//
//  Created by Raymond Chau on 3/17/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import Foundation

struct Attraction: Codable {
    let imgsrc: String?
    let title: String?
    let description: String?
    let lat: String?
    let lon: String?
    
    enum CodingKeys: String, CodingKey {
        case imgsrc = "imgsrc"
        case title = "title"
        case description = "description"
        case lat = "lat"
        case lon = "lon"
    }
}
