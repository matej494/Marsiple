//
//  PostsViewModel.swift
//  Marsiple
//
//  Created by Domagoj Kulundzic on 10/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

protocol PostsViewModel {
    var selectedPost: Dynamic<Post?> { get }
    var postCellViewModels: Dynamic<[PostTableViewCell.ViewModel]> { get }
    func numberOfRows(inSection section: Int) -> Int
    func viewModel(atIndexPath indexPath: IndexPath) -> PostTableViewCell.ViewModel
    func fetchPosts()
    func selectRow(atIndexPath indexPath: IndexPath)
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
