//
//  PostMediaConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

final class PostMediaConfigurator {
    public static func configurePostMediaView(with post: FeedPostData) -> PostMediaView {
        PostMediaView(viewModel: PostMediaViewModel(post: post))
    }
}
