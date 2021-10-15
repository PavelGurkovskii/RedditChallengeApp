//
//  PostVideoConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

final class PostVideoConfigurator {
    static public func configurePostVideoView(with url: URL?) -> PostVideoView<PostVideoViewModel> {
        PostVideoView(viewModel: PostVideoViewModel(url: url))
    }
}
