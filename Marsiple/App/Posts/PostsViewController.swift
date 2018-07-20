//
//  PostsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostsViewController: UIViewController {
    private var posts: [Post] = []
    private let postsView = PostsView.autolayoutView()
    private let postsFetcher = PostsFetcher()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigationBar()
        postsFetcher.getPosts(success: { [weak self] posts in
                                self?.posts = posts
                                self?.postsView.tableView.reloadData() },
                              failure: { error in
                                print(error.errorDescription) })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        cell.updateCell(withPost: posts[indexPath.row])
        return cell
    }
}

private extension PostsViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.Posts.navigationBarTitle.localized()
    }
    
    func setupView() {
        title = LocalizationKey.Posts.navigationBarTitle.localized()
        view.backgroundColor = .white
        view.addSubview(postsView)
        postsView.tableView.dataSource = self
        postsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
