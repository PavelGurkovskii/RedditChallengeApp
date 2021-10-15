//
//  PostRowView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import SwiftUI

struct PostRowView: View {
    private var viewModel: IPostRowViewModel
    
    init(viewModel: IPostRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            getTitleView()
            getPreviewView()
            Spacer()
            getInfoView().padding(.horizontal, 10)
            getDividerView()
        }
    }
    
    @ViewBuilder private func getTitleView() -> some View {
        HStack{
            Text(viewModel.title)
                .bold()
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 10)
            Spacer()
        }
    }
    
    @ViewBuilder private func getPreviewView() -> some View {
        PostMediaConfigurator.configurePostMediaView(with: viewModel.post)
    }
    
    @ViewBuilder private func getInfoView() -> some View {
        HStack {
            CommentsNumberConfigurator.configureCommentsNumberView(with: viewModel.commentsNumber)
            Spacer()
            ScoreNumberConfigurator.configureScoresNumberView(with: viewModel.score)
        }
    }
    
    @ViewBuilder private func getDividerView() -> some View {
        Rectangle()
            .fill(Color(UIColor.lightGray))
            .frame( height: 10)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(viewModel: PostRowViewModel(post: fakePost))
    }
}
