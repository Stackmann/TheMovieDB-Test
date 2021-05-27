//
//  ImageFromURL.swift
//  TheMovieDB-Test
//
//  Created by admin on 27.05.2021.
//

import SwiftUI

struct ImageFromURL: View {
    
    let urlString: String
    @State private var image: UIImage? = nil
    private var url: URL? {
        return URL(string: urlString)
    }
    var cache: ImageCache = Environment(\.imageCache).wrappedValue
    var attemptCount = 0
    
    var body: some View {
        
        ZStack {
            if let image = image {
                Image(uiImage: image)
                            .resizable()
            } else {
                Image("empty")
                    .resizable()
            }
        }
        .onAppear() {
            image = nil
            self.updateImage()
        }
        
    }
    
    private func updateImage() {
        
        guard let url = url else { return }
        if let image = cache[url] {
            self.image = image
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    self.image = try UIImage(data: Data(contentsOf: data))
                    self.putCache()
                } catch {
                    //print(error)
                    self.updateImage()
                }
            }
        }
        task.resume()
        
    }
    
    private func putCache() {
        if let url = url {
            cache.setObject(newValue: image, for: url)
        }
    }

}
    
struct ImageFromURL_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromURL(urlString: "http://image.tmdb.org/t/p/w300/xCEg6KowNISWvMh8GvPSxtdf9TO.jpg")

    }
}
