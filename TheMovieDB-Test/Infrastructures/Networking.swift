//
//  Networking.swift
//  TheMovieDB-Test
//
//  Created by admin on 26.05.2021.
//

import Foundation

protocol ObtainMovies {
    func getPopularMovies(with page: Int, completion: @escaping (Result<[MoviePop], Error>) -> Void)
    func getImageMovies(with movies: [MoviePop], completion: @escaping (Result<[MoviePop], Error>) -> Void)
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
    
    func getImageMovies(with movies: [MoviePop], completion: @escaping (Result<[MoviePop], Error>) -> Void) {
//        guard var urlComponents = URLComponents(string: Constants.movieImagePath) else {
//            completion(.failure(NetworkError.cantCreateURL))
//            return
//        }
//        var arrayMovies = [MoviePop]()
//        
//        let syncQueue = DispatchQueue(label: "Queue to sync mutation")
//        let group = DispatchGroup()
//        for movie in movies {
//            group.enter()
//            
//            urlComponents.path = urlComponents.path + "\(movie.posterPath)"
//            
//            guard let url = urlComponents.url else {
//                syncQueue.sync {
//                    arrayMovies.append(movie)
//                }
//                group.leave()
//                continue
//            }
//            
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                guard let response = response as? HTTPURLResponse else {
//                    group.leave()
//                    return
//                }
//                if let error = error {
//                    syncQueue.sync {
//                        arrayMovies.append(MoviePop(id: 1, name: "name", voteAverage: 0, posterPath: "", genreIds: [], overview: ""))
//                    }
//                } else {
//                    guard let data = data else {
//                        syncQueue.sync {
//                            arrayMovies.append(MoviePop(id: 1, name: "name", voteAverage: 0, posterPath: "", genreIds: [], overview: ""))
//                        }
//                        return
//                    }
//                    do {
//                        let weather = try JSONDecoder().decode(WeatherAnswer.self, from: data)
//                        //syncQueue.sync {
        //                        arrayMovies.append(MoviePop(id: 1, name: "name", voteAverage: 0, posterPath: "", genreIds: [], overview: ""))
//                        //}
//                    } catch {
//                        syncQueue.sync {
        //                        arrayMovies.append(MoviePop(id: 1, name: "name", voteAverage: 0, posterPath: "", genreIds: [], overview: ""))
//                        }
//                    }
//                }
//                
//                group.leave()
//            }.resume()
//        }
//        
//        group.notify(queue: .global()) {
//            completion(.success(arrayWeather))
//        }
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
