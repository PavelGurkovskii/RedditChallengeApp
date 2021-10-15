//
//  PostVideoView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import SwiftUI
import AVKit

struct PostVideoView<Model>: View where Model: IPostVideoViewModel{
    
    @ObservedObject private var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VideoPlayer(player: viewModel.player)
            .onAppear() {
                viewModel.onAppear()
            }
            .onDisappear() {
                viewModel.onDisappear()
            }
    }
}

struct PostVideoView_Previews: PreviewProvider {
    static var previews: some View {
        PostVideoView(viewModel: PostVideoViewModel(url: nil))
    }
}
