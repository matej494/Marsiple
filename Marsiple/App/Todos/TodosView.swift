//
//  TodosView.swift
//  Marsiple
//
//  Created by Matej Korman on 26/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodosView: UIView {
    let tableView = UITableView.autolayoutView()
    
    init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TodosView {
    func setupViews() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
