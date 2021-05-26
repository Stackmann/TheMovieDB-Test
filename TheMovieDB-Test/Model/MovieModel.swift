//
//  MovieModel.swift
//  TheMovieDB-Test
//
//  Created by admin on 25.05.2021.
//

import Foundation
import SwiftUI

struct Movie: Hashable, Codable {
    var id: Int
    var name: String
    var homePage: String
    var voteAverage: Double
    private var posterName: String
    var posterImage: Image {
        Image(posterName)
    }
    var rate: String {
        let starCount = Int(modf(voteAverage / 2).0)
        var rate = ""
        if starCount > 0 {
            for _ in 1...starCount {
                rate = rate + "★"
            }
        }
        return rate
    }
    var genres: [String]
    var language: String
    var releaseDate: String
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case homePage
        case voteAverage = "vote_average"
        case posterName = "poster_path"
        case genres
        case language = "original_language"
        case releaseDate = "release_date"
        case overview
    }
}
