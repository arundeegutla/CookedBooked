//
//  Album.swift
//  Flixster
//
//  Created by CHENGTAO on 3/13/23.
//

import Foundation

struct PosterSearchResponse: Decodable {
    let results: [Poster]
}

struct Poster: Decodable {
    let poster_path: URL
}
