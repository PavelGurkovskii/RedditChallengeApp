//
//  PostRowViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import Foundation
import UIKit
import Combine

protocol IPostRowViewModel {
    var post: FeedPostData { get }
    var title: String { get }
    var score:  CurrentValueSubject<String, Never> { get }
    var commentsNumber: CurrentValueSubject<String, Never> { get }
}

final class PostRowViewModel: IPostRowViewModel {
    
    var score: CurrentValueSubject<String, Never>
    var commentsNumber: CurrentValueSubject<String, Never>
    let post: FeedPostData
    
    var title: String {
        post.title ?? ""
    }
    
    init(post: FeedPostData) {
        self.post = post
        self.score = CurrentValueSubject<String, Never>("\(post.score ?? 0)")
        self.commentsNumber = CurrentValueSubject<String, Never>("\(post.num_comments ?? 0)")
    }
}
