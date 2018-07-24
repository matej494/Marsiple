//
//  CommentViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class CommentViewController: UIViewController {
    private let postId: Int
    private let commentView = CommentView.autolayoutView()
    
    init(postId: Int) {
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CommentViewController {
    @objc func saveButtonTapped() {
        let comment = Comment(id: 1, name: "John Doe", email: "johndoe@gmail.com", body: commentView.text, postId: postId) // NOTE: - Id is set to 1, but it will be supplied by API. There is no name and email (possible upgrade when registration is implemented).
        MartianApiManager.postComment(comment: comment)
        navigationController?.popViewController(animated: true)
    }
}

private extension CommentViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.Comment.navigationBarTitle.localized()
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupView() {
        view.backgroundColor = .martianLightGrey
        view.addSubview(commentView)
        commentView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
