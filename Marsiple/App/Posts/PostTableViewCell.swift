//
//  PostTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostTableViewCell: UITableViewCell {
    private let postView = TitleAndBodyView.autolayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    func updateCell(title: String, body: String) {
        postView.updateProperties(title: title, body: body)
    }
}

private extension PostTableViewCell {
    func setupViews() {
        accessoryType = .disclosureIndicator
        backgroundColor = .martianLightGrey
        contentView.addSubview(postView)
        postView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
