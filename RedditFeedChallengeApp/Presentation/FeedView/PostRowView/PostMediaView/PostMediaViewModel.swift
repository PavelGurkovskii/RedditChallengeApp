//
//  PostMediaViewModel.swift
//  RedditFeedChallengeApp
//
//  Created by Pavel Gurkovskii on 14.10.2021.
//

import Foundation

enum PostMediaViewType {
    case text
    case image
    case video
    case gallery
}

protocol IPostMediaViewModel {
    var mediaType: PostMediaViewType { get }
    var url: URL? { get }
    var ratio: Float { get }
}

final class PostMediaViewModel: IPostMediaViewModel {
    
    var mediaType: PostMediaViewType {
        if post.is_gallery ?? false {
            return .gallery
        }
        return post.is_video ? .video : (post.thumbnail_height == nil ? .text : .image)
    }
    
    var url: URL? {
        URL(string: urlString ?? "")
    }
    
    var ratio: Float {
        Float(post.thumbnail_height ?? 0) / Float(post.thumbnail_width ?? 1)
    }
    
    private var urlString: String? {
        if post.is_gallery ?? false {
            return post.thumbnail
        }
        if post.is_video {
            return post.media?.reddit_video?.fallback_url
        }
        return  post.url?.containsImage ?? false ? post.url : post.thumbnail
    }
    
    private var post: FeedPostData
    
    init(post: FeedPostData) {
        self.post = post
    }
}
