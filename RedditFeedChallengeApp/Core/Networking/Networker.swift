//
//  Networker.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 13.10.2021.
//

import Foundation
import Combine

protocol NetworkerProtocol: AnyObject {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T: Decodable
}

final class Networker: NetworkerProtocol {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
