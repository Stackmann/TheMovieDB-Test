//
//  Networking.swift
//  TheMovieDB-Test
//
//  Created by admin on 26.05.2021.
//

import Foundation

protocol ObtainMovies {
    func getPopularMovies(with page: Int, completion: @escaping (Result<[MoviePop], Error>) -> Void)
    func getMovie(with movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void)
}

class TheMovieDB: ObtainMovies {
    
    func getPopularMovies(with page: Int, completion: @escaping (Result<[MoviePop], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.popularMoviesPath) else {
            completion(.failure(NetworkError.cantCreateURL))
            return
        }
        
        urlComponents.query = "api_key=\(Constants.apiKey)&page=\(page)"
        
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
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getMovie(with movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.movieDetailPath) else {
            completion(.failure(NetworkError.cantCreateURL))
            return
        }
        urlComponents.path = urlComponents.path + "\(movieId)"
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
                    let responseResult = try JSONDecoder().decode(Movie.self, from: data)
                    completion(.success(responseResult))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()

    }
    
    func getCast(with movieId: Int, completion: @escaping (Result<[Cast], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.movieDetailPath) else {
            completion(.failure(NetworkError.cantCreateURL))
            return
        }
        
        urlComponents.path = urlComponents.path + "\(movieId)" + "/credits"
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
                    let responseResult = try JSONDecoder().decode(CastResponse.self, from: data)
                    completion(.success(responseResult.cast))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }


    enum NetworkError: Error {
        case cantCreateURL
        case cantRetriveData
    }
}

struct Response: Codable {
    var page: Int
    var movies: [MoviePop]
    var totalResults: Int
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct CastResponse: Codable {
    var id: Int
    var cast: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id, cast
    }
}
