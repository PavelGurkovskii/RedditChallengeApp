//
//  CommentsNumberViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import Foundation
import Combine

protocol ICommentsNumberViewModel: ObservableObject {
    var commentsNumber: String{ get set }
}

final class CommentsNumberViewModel: ICommentsNumberViewModel {
    @Published internal var commentsNumber: String = ""
    private var cancellables = [AnyCancellable]()
    
    init(commentsNumber: CurrentValueSubject<String, Never>) {
        subscribe(commentsNumber: commentsNumber)
    }
    
    private func subscribe(commentsNumber: CurrentValueSubject<String, Never>) {
        cancellables.removeAll()
        commentsNumber.sink { [weak self] value in
            self?.commentsNumber = value
        }.store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
