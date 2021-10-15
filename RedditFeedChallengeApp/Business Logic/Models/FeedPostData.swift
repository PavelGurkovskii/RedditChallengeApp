//
//  FeedPostData.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 12.10.2021.
//

import Foundation

struct FeedPostData: Codable, Hashable {
    var title: String?
    var hidden: Bool?
    var hide_score: Bool?
    var thumbnail_width: Int?
    var thumbnail_height: Int?
    var score: Int?
    var thumbnail: String?
    var num_comments: Int?
    var url: String?
    var id: String?
    var is_video: Bool
    var media: FeedPostMedia?
}

let fakePost = FeedPostData(title: "Test Titla", hidden: false, hide_score: false, thumbnail_width: 200, thumbnail_height: 100, score: 50, thumbnail: "", num_comments: 1000, url: "", id: "id", is_video: false)
