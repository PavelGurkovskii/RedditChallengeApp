//
//  PostMediaView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import SwiftUI

struct PostMediaView: View {
    
    
    private var viewModel: IPostMediaViewModel
    private var mediaUrl: URL? {
        viewModel.url
    }
    
    init(viewModel: IPostMediaViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.mediaType == .text {
            EmptyView()
        } else {
            getContenView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * CGFloat(viewModel.ratio))
        }
    }
    
    @ViewBuilder private func getContenView() -> some View {
        switch viewModel.mediaType {
        case .text:
            EmptyView()
        case .video:
            PostVideoConfigurator.configurePostVideoView(with: mediaUrl)
        case .image, .gallery:
            PostImageConfigurator.configurePostImageView(with: mediaUrl)
        }
    }
}

struct PostMediaView_Previews: PreviewProvider {
    static var previews: some View {
        PostMediaView(viewModel: PostMediaViewModel(post: fakePost))
    }
}
