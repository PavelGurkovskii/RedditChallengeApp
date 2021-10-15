//
//  FeedListViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 12.10.2021.
//

import Foundation
import SwiftUI
import Combine

final class FeedListViewModel: ObservableObject {
    
    private var cancellables = [AnyCancellable]()
    
    @Published var items: [FeedPostData] = []
    
    @Published var isLoadingPage:Bool = true
    @Published var loadingError: Error?
    
    private var dataSource: InfiniteLoader
    
    init(dataSource: InfiniteLoader) {
        self.dataSource = dataSource
        subscribe()
    }
    
    private func subscribe() {
        cancellables.removeAll()
        dataSource.items.sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.loadingError = error
            case .finished:
                break
            }
        }, receiveValue: { [weak self] data in
            self?.items = data
        }).store(in: &cancellables)
        
        dataSource.isLoadingPage.sink{ [weak self] value in
            self?.isLoadingPage = value
        }.store(in: &cancellables)
    }
    
    func loadNextIfNeeded(currentItem item: FeedPostData?) throws {
        try dataSource.loadNextIfNeeded(currentItem: item)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
