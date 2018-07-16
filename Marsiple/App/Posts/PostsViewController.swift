//
//  PostsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostsViewController: UIViewController {
    private let posts = [Post(title: "Title 1", body: "Body 1"),
                         Post(title: "Title 2", body: "Body 2"),
                         Post(title: "Title 3", body: "Body 3"),
                         Post(title: "Title 4", body: "Body 4"),
                         Post(title: "Title 5", body: "Body 5"),
                         Post(title: "Title 6", body: "Body 6")]
    private let postsView = PostsView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        postsView.tableView.dataSource = self
        setupView()
        setupNavigationBar()
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
        view.backgroundColor = .white
        view.addSubview(postsView)
        postsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
