//
//  AlbumsView.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlbumsView {
    func setupViews() {
        setupTableView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.rowHeight = 70
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
