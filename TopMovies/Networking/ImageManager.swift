//
//  ImageManager.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import UIKit

class ImageLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func downloadImageWithPath(imagePath: String, isFromDetail: Bool = false, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage(systemName: "photo")?.withTintColor(.baseColor500, renderingMode: .alwaysOriginal) ?? UIImage()
            DispatchQueue.main.async {
                isFromDetail ? completionHandler(nil) : completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let image: UIImage! = UIImage(data: data)
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            })
            task.resume()
        }
    }
}
