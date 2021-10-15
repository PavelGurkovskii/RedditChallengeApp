//
//  CommentsNumberConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation
import Combine

final class CommentsNumberConfigurator {
    public static func configureCommentsNumberView(with commentsNumber:CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")) -> CommentsNumberView<CommentsNumberViewModel> {
        CommentsNumberView(viewModel: CommentsNumberViewModel(commentsNumber: commentsNumber))
    }
}
