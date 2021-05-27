//
//  ImageCache.swift
//  TheMovieDB-Test
//
//  Created by admin on 27.05.2021.
//

import UIKit
import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
    func setObject(newValue: UIImage?, for key: URL)
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    func setObject(newValue: UIImage?, for key: URL) {
        if newValue == nil {
            cache.removeObject(forKey: key as NSURL)
        } else {
            cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
