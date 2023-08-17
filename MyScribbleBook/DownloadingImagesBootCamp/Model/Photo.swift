//
//  Photo.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import Foundation

struct Photo: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
