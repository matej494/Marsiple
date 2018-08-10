//
//  PostsViewModelImpl.swift
//  Marsiple
//
//  Created by Domagoj Kulundzic on 10/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class PostsViewModelImpl: PostsViewModel {
    private(set) var selectedPost = Dynamic<Post?>(nil)
    private(set) var postCellViewModels = Dynamic([PostTableViewCell.ViewModel]())
    private var posts = [Post]()
    
    func fetchPosts() {
        MartianApiManager.getPosts(success: { [weak self] posts in
            self?.posts = posts
            self?.postCellViewModels.value = posts.map { PostTableViewCell.ViewModel($0.title, $0.body) }
            }, failure: { error in
                print(error.localizedDescription)
        })
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        selectedPost.value = posts[indexPath.row]
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return posts.count
    }
    
    func viewModel(atIndexPath indexPath: IndexPath) -> PostTableViewCell.ViewModel {
        return postCellViewModels.value[indexPath.row]
    }
}
