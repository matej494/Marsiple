//
//  PostDetailsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostDetailsViewController: UIViewController {
    private let post: Post
    // TODO: - Populate with real data.
    private var comments = [Comment](repeating: Comment(email: "test.test@test.com", body: "Test comment..."), count: 10)
    private let postDetailsView = PostDetailsView.autolayoutView()
    
    override var hidesBottomBarWhenPushed: Bool {
        get { return true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.postDetailsTableViewCell, for: indexPath) as? PostDetailsTableViewCell else { return UITableViewCell()}
        let comment = comments[indexPath.row]
        cell.updateProperties(email: comment.email, body: comment.body)
        return cell
    }
}

private extension PostDetailsViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.PostDetails.navigationBarTitle.localized()
    }
    
    func setupView() {
        view.addSubview(postDetailsView)
        view.backgroundColor = .martianLightGrey
        postDetailsView.updatePostProperties(title: post.title, body: post.body)
        postDetailsView.tableView.dataSource = self
        postDetailsView.tableView.register(PostDetailsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.postDetailsTableViewCell)
        postDetailsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
