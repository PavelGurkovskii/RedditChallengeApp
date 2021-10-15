//
//  ScoreNumberView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import SwiftUI
import Combine

struct ScoreNumberView<Model>: View where Model: IScoreNumberViewModel {
    @ObservedObject private var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.arrow.down")
            Text(viewModel.scoreNumber)
        }
    }
}

struct ScoreNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreNumberView(viewModel: ScoreNumberViewModel(scoreNumber: CurrentValueSubject<String, Never>("")))
    }
}
