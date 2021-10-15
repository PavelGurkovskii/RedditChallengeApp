//
//  CommentsNumberView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import SwiftUI
import Combine

struct CommentsNumberView<Model>: View where Model: ICommentsNumberViewModel{
    @ObservedObject private var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image(systemName: "bubble.left")
            Text(viewModel.commentsNumber)
        }
    }
}

struct CommentsNumberView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsNumberView(viewModel: CommentsNumberViewModel(commentsNumber: CurrentValueSubject<String, Never>("")))
    }
}
