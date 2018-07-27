//
//  CommentViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class CommentViewController: UIViewController {
    private let commentView = CommentView.autolayoutView()
    
    init() {
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
        // TODO: Implement posting comment on-line
        navigationController?.popViewController(animated: true)
    }
}

private extension CommentViewController {
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.Comment.navigationBarTitle.localized()
        let saveButton = UIBarButtonItem.createSaveItem(target: self, action: #selector(saveButtonTapped))
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
