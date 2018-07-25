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
    private var comments = [Comment]()
    private let postDetailsView = PostDetailsView.autolayoutView()
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        DataFetcher.getComments(forPostId: post.id,
                                success: { [weak self] comments in
                                    self?.comments = comments
                                    self?.postDetailsView.tableView.reloadData() },
                                failure: { error in
                                    print(error.errorDescription) })
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
    @objc func commentButtonTapped() {
        navigationController?.pushViewController(CommentViewController(), animated: true)
    }
}

private extension PostDetailsViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.PostDetails.navigationBarTitle.localized()
        let commentButton = UIBarButtonItem.createCommentItem(target: self, action: #selector(commentButtonTapped))
        navigationItem.rightBarButtonItem = commentButton
    }
    
    func setupView() {
        view.backgroundColor = .martianLightGrey
        view.addSubview(postDetailsView)
        postDetailsView.updatePostProperties(title: post.title, body: post.body)
        postDetailsView.tableView.dataSource = self
        postDetailsView.tableView.register(PostDetailsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.postDetailsTableViewCell)
        postDetailsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}