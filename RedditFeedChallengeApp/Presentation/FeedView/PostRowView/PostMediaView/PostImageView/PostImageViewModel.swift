//
//  PostImageViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 12.10.2021.
//

import Foundation
import UIKit
import Combine
import SwiftUI

protocol IPostImageViewModel {
    var url: URL? { get }
}

final class PostImageViewModel: IPostImageViewModel{
    
    var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
}
