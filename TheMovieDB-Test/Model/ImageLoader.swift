//
//  ImageLoader.swift
//  TheMovieDB-Test
//
//  Created by admin on 27.05.2021.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.downloadTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    self.data = try Data(contentsOf: data)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
        
    }
}


