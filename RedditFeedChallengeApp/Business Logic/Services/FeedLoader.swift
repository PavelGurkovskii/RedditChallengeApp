//
//  FeedLoader.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import Foundation
import Combine
import SwiftUI

protocol InfiniteLoader {
    var items: CurrentValueSubject<[FeedPostData], Error> { get }
    var isLoadingPage: CurrentValueSubject<Bool, Never> { get }
    
    func loadNextIfNeeded(currentItem item: FeedPostData?) throws
}

enum ContentUrls: String {
    case feed = "http://www.reddit.com/.json"
    case feedNext = "http://www.reddit.com/.json?after="
}

enum FeedLoadingError: Error {
    case invalidUrl
    case invalidData
}

final class FeedLoader: InfiniteLoader, ObservableObject {

    var items = CurrentValueSubject<[FeedPostData], Error>([])
    var isLoadingPage = CurrentValueSubject<Bool, Never>(false)
    
    private let networker: NetworkerProtocol
    private var afterPage = ""
    private var canLoadMorePages = true
    private var cancellables = [AnyCancellable]()
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
//        try? loadFeed()
    }
    
    func loadNextIfNeeded(currentItem item: FeedPostData?) throws {
        guard let item = item else {
            try loadFeed()
            return
        }
        
        if needToLoadNext(currentItem: item) {
            try loadFeed()
        }
    }
    
    private func needToLoadNext(currentItem item: FeedPostData) -> Bool {
        let endIndex = items.value.endIndex
        let thresholdIndex = items.value.index(endIndex, offsetBy: -10)
        
        return items.value.firstIndex(where: { $0.id == item.id }) == thresholdIndex
    }
    
    private func loadFeed() throws {
        guard !isLoadingPage.value && canLoadMorePages else {
          return
        }
        
        let url: URL
        do {
            url = try getUrl()
        } catch {
            throw error
        }
        clearSubscriptions()
        processFeedLoading(url: url)
    }
    
    private func processFeedLoading(url: URL) {
        isLoadingPage.value = true
        networker.get(type: FeedResponse.self, url: url).sink { [weak self]  result in
            switch result {
            case .failure(let error):
                self?.items.send(completion: .failure(error))
            case .finished:
                break
            }
            self?.isLoadingPage.value = false
        } receiveValue: { [weak self] response in
            self?.isLoadingPage.value = false
            self?.updateLocalState(response: response)
            self?.addNewItems(from: response)
        }.store(in: &cancellables)
    }
    
    
    private func addNewItems(from response: FeedResponse) {
        items.value = items.value + response.data.children.compactMap({ feedPost in
            feedPost.data
        })
    }
    
    private func clearSubscriptions() {
        cancellables.removeAll()
    }
    
    private func updateLocalState(response: FeedResponse) {
        canLoadMorePages = response.data.after.count != 0
        afterPage = response.data.after
    }
    
    private func getUrl() throws -> URL {
        guard let url = URL(string: ContentUrls.feedNext.rawValue +  "\(afterPage)") else {
            throw FeedLoadingError.invalidUrl
        }
        return url
    }
}
