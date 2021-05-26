//
//  Networking.swift
//  TheMovieDB-Test
//
//  Created by admin on 26.05.2021.
//

import Foundation

protocol ObtainMovies {
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class TheMovieDB: ObtainMovies {
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.popularMoviesPath) else {
            completion(.failure(NetworkError.cantCreateURL))
            return
        }
        
        urlComponents.query = "api_key=\(Constants.apiKey)"
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.cantCreateURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard (response as? HTTPURLResponse) != nil else {
                return
            }
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else {
                    completion(.failure(NetworkError.cantRetriveData))
                    return
                }
                do {
                    let responseResult = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(responseResult.movies))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
    }

    enum NetworkError: Error {
        case cantCreateURL
        case cantRetriveData
    }
}

struct Response: Codable {
    var movies: [Movie]
}
