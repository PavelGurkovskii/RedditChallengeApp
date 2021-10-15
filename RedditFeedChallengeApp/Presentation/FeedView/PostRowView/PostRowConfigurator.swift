//
//  PostRowConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

final class PostRowConfigurator {
    public static func configurePostRow(with post: FeedPostData) -> PostRowView {
        PostRowView(viewModel: PostRowViewModel(post: post))
    }
}
