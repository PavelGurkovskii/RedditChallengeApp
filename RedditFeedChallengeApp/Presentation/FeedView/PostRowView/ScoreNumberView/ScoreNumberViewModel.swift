//
//  ScoreNumberViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import Foundation
import Combine

protocol IScoreNumberViewModel: ObservableObject {
    var scoreNumber: String{ get set }
}

final class ScoreNumberViewModel: IScoreNumberViewModel {
    @Published internal var scoreNumber: String = ""
    private var cancellables = [AnyCancellable]()
    
    init(scoreNumber: CurrentValueSubject<String, Never>) {
        subscribe(scoreNumber: scoreNumber)
    }
    
    private func subscribe(scoreNumber: CurrentValueSubject<String, Never>) {
        cancellables.removeAll()
        scoreNumber.sink { [weak self] value in
            self?.scoreNumber = value
        }.store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
