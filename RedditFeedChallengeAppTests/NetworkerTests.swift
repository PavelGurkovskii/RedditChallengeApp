//
//  NetworkerTests.swift
//  RedditFeedChallengeAppTests
//
//  Created by Pavel Gurkovskii on 15.10.2021.
//

import XCTest
import Combine
@testable import RedditFeedChallengeApp

class NetworkerTests: XCTestCase {
    var networker: NetworkerProtocol!
    var cancellables = [AnyCancellable]()
    
    override func setUpWithError() throws {
        networker = Networker()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testValidUrl() throws {
        let url = Bundle(for: NetworkerTests.self).url(forResource: "FeedDataValid", withExtension: "txt")
        let result = networker.get(type: FeedResponse.self, url: url!)
        cancellables.removeAll()
        let promise = expectation(description: "Valid url")
        result.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            default:
                promise.fulfill()
            }
            
        } receiveValue: { _ in
            
        }.store(in: &cancellables)
        wait(for: [promise], timeout: 2.0)

    }
    
    func testInvalidUrl() throws {
        let url = URL(string: "https://www.reit.cm")
        let result = networker.get(type: FeedResponse.self, url: url!)
        let promise = expectation(description: "Failure called")
        cancellables.removeAll()
        result.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Should throw error when url is invalid")
            default:
                promise.fulfill()
            }
            
        } receiveValue: { _ in
            
        }.store(in: &cancellables)
        wait(for: [promise], timeout: 2.0)
    }
    
    func testInvalidFormat() throws {
        let url = Bundle(for: NetworkerTests.self).url(forResource: "FeedDataInvalid", withExtension: "txt")
        let result = networker.get(type: FeedResponse.self, url: url!)
        cancellables.removeAll()
        let promise = expectation(description: "Failure called")
        result.sink { completion in
            switch completion {
            case .failure(_):
                promise.fulfill()
            default:
                XCTFail("Should throw error when wrong data format")
            }
            
        } receiveValue: { response in
            
        }.store(in: &cancellables)
        
        wait(for: [promise], timeout: 2.0)
    }
    
    func testValidFormat() throws {
        let url = Bundle(for: NetworkerTests.self).url(forResource: "FeedDataValid", withExtension: "txt")
        let result = networker.get(type: FeedResponse.self, url: url!)
        cancellables.removeAll()
        let promise = expectation(description: "Data parsed successfuly")
        result.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            default:
                break
            }
            
        } receiveValue: { _ in
            promise.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [promise], timeout: 2.0)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
