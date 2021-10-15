//
//  FeedListView.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 11.10.2021.
//

import SwiftUI
import Combine

struct FeedListView: View {
    
    @ObservedObject private var viewModel: FeedListViewModel
    private var cancelables = [AnyCancellable]()
    
    init(viewModel: FeedListViewModel) {
        self.viewModel = viewModel
        subscribe()
    }
    
    private mutating func subscribe() {
        viewModel.$loadingError.sink { error in
            guard let error = error else {
                return
            }
            print(error.localizedDescription)
        }.store(in: &cancelables)
    }
    
    var body: some View {
        List{
            ForEach(viewModel.items, id: \.self) { item in
                PostRowConfigurator.configurePostRow(with: item)
                    .onAppear {
                        self.loadNextRows(with: item)
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: -20, bottom: 10, trailing: -20)).fixedSize(horizontal: false, vertical: true)
            }
            
        }.listStyle(SidebarListStyle()).onAppear {
            self.loadNextRows()
        }
        
        if viewModel.isLoadingPage {
            HStack() {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
    
    private func loadNextRows(with item: FeedPostData? = nil) {
        do {
            try viewModel.loadNextIfNeeded(currentItem: item)
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView(viewModel: FeedListViewModel(dataSource: FeedLoader()))
    }
}
