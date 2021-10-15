//
//  PostImageView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 12.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostImageView: View {
    
    private var viewModel: IPostImageViewModel
    
    init(viewModel: IPostImageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        WebImage(url: viewModel.url)
            .resizable()
            .background(Color.gray)
    }
}

struct PostImageView_Previews: PreviewProvider {
    static var previews: some View {
        PostImageView(viewModel: PostImageViewModel(url: nil))
    }
}
