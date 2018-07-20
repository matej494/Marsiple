//
//  PostsView.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostsView: UIView {
    let tableView = UITableView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PostsView {
    func setupViews() {
        backgroundColor = .martianLightGrey
        setupTableview()
    }
    
    func setupTableview() {
        tableView.backgroundColor = .martianLightGrey
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
