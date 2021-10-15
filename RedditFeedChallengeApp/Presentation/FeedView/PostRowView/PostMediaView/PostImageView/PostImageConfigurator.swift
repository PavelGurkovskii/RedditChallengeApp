//
//  PostImageConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

final class PostImageConfigurator {
    static public func configurePostImageView(with url: URL?) -> PostImageView {
        PostImageView(viewModel: PostImageViewModel(url: url))
    }
}
