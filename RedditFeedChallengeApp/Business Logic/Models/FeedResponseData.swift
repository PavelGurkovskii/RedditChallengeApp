//
//  FeedResponseData.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 12.10.2021.
//

import Foundation

struct FeedResponseData: Codable {
    var after: String
    var children: [FeedPost]
}
