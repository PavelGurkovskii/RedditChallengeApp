//
//  ScoreNumberConfigurator.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

import Combine

final class ScoreNumberConfigurator {
    public static func configureScoresNumberView(with scoreNumber:CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")) -> ScoreNumberView<ScoreNumberViewModel> {
        ScoreNumberView(viewModel: ScoreNumberViewModel(scoreNumber: scoreNumber))
    }
}
