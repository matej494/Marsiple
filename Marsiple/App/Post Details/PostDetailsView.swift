//
//  PostDetailsView.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostDetailsView: UIView {
    let tableView = UITableView.autolayoutView()
    private let postView = TitleAndBodyView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostDetailsView {
    func updatePostProperties(title: String, body: String) {
        postView.updateProperties(title: title, body: body)
    }
}

private extension PostDetailsView {
    func setupViews() {
        backgroundColor = .martianLightGrey
        setupPostDetailsView()
        setupTableView()
    }
    
    func setupPostDetailsView() {
        addSubview(postView)
        postView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .martianLightGrey
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(postView.snp.bottom).inset(-10)
        }
    }
}
