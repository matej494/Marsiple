//
//  CommentViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class CommentViewController: UIViewController {
    private let updateComments: () -> Void
    private let postId: Int
    private let commentView = CommentView.autolayoutView()
    
    init(postId: Int, updateComments: @escaping () -> Void) {
        self.postId = postId
        self.updateComments = updateComments
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
        // NOTE: - Id is set to 1, but it won't be encoded, so API will supply it. There is no name and email (possible upgrade when registration is implemented).
        let comment = Comment(id: 1,
                              name: "John Doe",
                              email: "johndoe@gmail.com",
                              body: commentView.text,
                              postId: postId)
        MartianApiManager.postComment(comment: comment,
                                      success: { [weak self] message in
                                        let alert = UIAlertController
                                            .alertStyle(title: LocalizationKey.Comment.successAlertTitle.localized(),
                                                        message: LocalizationKey.Comment.successAlertMessage.localized(message),
                                                        cancelActionTitle: LocalizationKey.Comment.okAlertAction.localized(),
                                                        cancelActionHandler: { [weak self] _ in
                                                            self?.updateComments()
                                                            self?.navigationController?.popViewController(animated: true) })
                                        self?.present(alert, animated: true, completion: nil) },
                                      failure: { [weak self] error in
                                        let message = error.localizedDescription ?? ""
                                        let alert = UIAlertController
                                            .alertStyle(title: LocalizationKey.Comment.failureAlertTitle.localized(),
                                                        message: LocalizationKey.Comment.failureAlertMessage.localized(message),
                                                        cancelActionTitle: LocalizationKey.Comment.cancelAlertAction.localized(),
                                                        cancelActionHandler: { [weak self] _ in
                                                            self?.navigationController?.popViewController(animated: true) })
                                        alert.addAction(UIAlertAction(title: LocalizationKey.Comment.stayHereAlertAction.localized(),
                                                                      style: .default,
                                                                      handler: nil))
                                        self?.present(alert, animated: true, completion: nil) })
    }
}

private extension CommentViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.Comment.navigationBarTitle.localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem.saveItem(target: self, action: #selector(saveButtonTapped))
    }
    
    func setupView() {
        view.backgroundColor = .martianLightGrey
        view.addSubview(commentView)
        commentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
}
