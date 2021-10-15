//
//  URLLoader.swift
//  RedditFeedChallangeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import Foundation

final class URLLoader {
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func start(completion: @escaping (Data?)->Void) {
        guard let imageURL = URL(string: urlString) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
}
