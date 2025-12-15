//
//  ImageLoader.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import UIKit

final class ImageLoader {
    private var task: URLSessionDataTask?
    
    func load(
        from url: URL,
        key: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        if let cached = ImageCacheManager.shared.image(forKey: key) {
            completion(.success(cached))
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            ImageCacheManager.shared.save(image, forKey: key)
            completion(.success(image))
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}

