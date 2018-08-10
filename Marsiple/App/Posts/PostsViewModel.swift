//
//  PostsViewModel.swift
//  Marsiple
//
//  Created by Domagoj Kulundzic on 10/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

protocol PostsViewModelDelegate: class {
    func didFetchPosts(viewModels: [PostTableViewCell.ViewModel])
}

protocol PostsViewModel {
    var selectedPost: Dynamic<Post?> { get }
    var postCellViewModels: Dynamic<[PostTableViewCell.ViewModel]> { get }
    func numberOfRows(inSection section: Int) -> Int
    func viewModel(atIndexPath indexPath: IndexPath) -> PostTableViewCell.ViewModel
    func fetchPosts()
    func selectRow(atIndexPath indexPath: IndexPath)
}

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

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}

extension Dynamic {
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
