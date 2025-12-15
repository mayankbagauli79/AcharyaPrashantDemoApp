//
//  ImageCacheManager.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    func image(forKey key: String) -> UIImage? {
        if let image = MemoryImageCache.shared.image(forKey: key) {
            return image
        }
        
        if let image = DiskImageCache.shared.image(forKey: key) {
            MemoryImageCache.shared.set(image, forKey: key)
            return image
        }
        
        return nil
    }
    
    func save(_ image: UIImage, forKey key: String) {
        MemoryImageCache.shared.set(image, forKey: key)
        DiskImageCache.shared.save(image, forKey: key)
    }
}
