//
//  FeedLoaderTests.swift
//  RedditFeedChallengeAppTests
//
//  Created by Pavel Gurkovskii on 15.10.2021.
//

import XCTest
import Combine

@testable import RedditFeedChallengeApp

class FeedLoaderTests: XCTestCase {

    var cancellables = [AnyCancellable]()
    var feedLoader: FeedLoader?
    
    class NetworkerMock: NetworkerProtocol {
        var index = 0
        
        var resultFake: FeedResponse {
            let feedResponseData = FeedResponseData(after: "1", children: getFakePosts(after: index))
            return FeedResponse(data: feedResponseData)
        }
        func getFakePosts(after index: Int) -> [FeedPost] {
            var posts = [FeedPost]()
            for i in index...index + 50 {
                let feedPost = FeedPost(data: FeedPostData(title: "Title \(i)", hidden: false, hide_score: false, thumbnail_width: 300, thumbnail_height: 200, score: 100 + i, thumbnail: "", num_comments: 200 + i, url: "", id: "\(i)", is_video: false, media: nil))
                posts.append(feedPost)
            }
            
            return posts
        }
        
        func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
            index += 51
            return CurrentValueSubject<T, Error>(resultFake as! T).eraseToAnyPublisher()
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessLoadFeed() throws {
        let feedLoader = FeedLoader(networker: NetworkerMock())
        let promise = expectation(description: "Loaded succesfully")
        
        feedLoader.items.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            default:
                break
            }
        } receiveValue: { posts in
            promise.fulfill()
        }.store(in: &cancellables)

        try feedLoader.loadNextIfNeeded(currentItem: nil)
        
        wait(for: [promise], timeout: 2.0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLoadingSeveralPages() {
        feedLoader = FeedLoader(networker: NetworkerMock())
        let promise = expectation(description: "Loaded succesfully")
        promise.expectedFulfillmentCount = 6
        var attempts = 0
        feedLoader?.items.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            default:
                break
            }
        } receiveValue: { [weak self] posts in
            if posts.count == 0 {
                return
            }
            promise.fulfill()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                try? self?.feedLoader?.loadNextIfNeeded(currentItem: posts[posts.count - 10])
            }
        }.store(in: &cancellables)

        attempts += 1
        try? feedLoader?.loadNextIfNeeded(currentItem: nil)
        
        wait(for: [promise], timeout: 10.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
