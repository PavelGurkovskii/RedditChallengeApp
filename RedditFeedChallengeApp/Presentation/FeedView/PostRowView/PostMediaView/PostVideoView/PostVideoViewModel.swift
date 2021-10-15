//
//  PostVideoViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation
import AVKit
import SwiftUI

protocol IPostVideoViewModel: ObservableObject {
    func onAppear()
    func onDisappear()
    var player: AVPlayer { get }
}

final class PostVideoViewModel: IPostVideoViewModel {
    
    @Published var player = AVPlayer()
    
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func onAppear() {
        playVideo()
    }
    
    func onDisappear() {
        pauseVideo()
    }
    
    private func playVideo() {
        guard let url = url else {
            return
        }
        player = AVPlayer(url: url)
        player.seek(to: .zero)
        player.play()
    }
    
    private func pauseVideo() {
        player.pause()
    }
}
