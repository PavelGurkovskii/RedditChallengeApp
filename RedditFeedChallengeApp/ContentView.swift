//
//  ContentView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FeedListView(viewModel: FeedListViewModel(dataSource: FeedLoader()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
