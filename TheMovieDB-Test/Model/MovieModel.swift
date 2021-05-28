//
//  MovieModel.swift
//  TheMovieDB-Test
//
//  Created by admin on 25.05.2021.
//

import Foundation
import SwiftUI
import Combine

struct Movie: Hashable, Codable {
    var id: Int
    var name: String
    var homePage: String?
    var voteAverage: Double
    var posterName: String?
    var posterImage: Image {
        Image("empty")
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
    var genres: [Genre]
    var language: String
    var releaseDate: String
    var overview: String?
    
    init(from moviePop: MoviePop) {
        self.id = moviePop.idMovie
        self.name = moviePop.name
        self.homePage = ""
        self.voteAverage = moviePop.voteAverage
        self.posterName = moviePop.posterPath
        self.genres = []
        self.language = ""
        self.releaseDate = ""
        self.overview = moviePop.overview
    }
    
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
    
    struct Genre: Codable, Hashable {
        var id: Int
        var name: String
    }
}

struct MoviePop: Hashable, Codable, Identifiable {
    var id = UUID()
    
    var idMovie: Int
    var name: String
    var voteAverage: Double
    var posterPath: String
    var posterImage: Image {
        Image("empty")
    }
    var genreIds: [Int]
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case idMovie = "id"
        case name = "title"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview
    }
}

class Storage: ObservableObject {
    @Published var popularMovies: [MoviePop] = []
    
    private var curentPage = 0

    func loadPolular() {
        curentPage += 1
        TheMovieDB().getPopularMovies(with: curentPage) { result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let receivedMovies):
                DispatchQueue.main.async {
                    self.popularMovies += receivedMovies
                }
            }
        }
    }


}

class StorageMovie: ObservableObject {
    @Published var state: MovieState = .isLoading
    var movie: Movie!
    let moviePop: MoviePop

    enum MovieState {
        case isLoading
        case isError
        case hasBeenLoaded
    }

    init(with moviePop: MoviePop) {
        self.moviePop = moviePop
    }
    
    func loadMovie() {
        TheMovieDB().getMovie(with: self.moviePop.idMovie) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.state = .isError
                    print(error.localizedDescription)
                case .success(let receivedMovie):
                    self.movie = receivedMovie
                    self.state = .hasBeenLoaded
                }
            }
        }
    }
}
