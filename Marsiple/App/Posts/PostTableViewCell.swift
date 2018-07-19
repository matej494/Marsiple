//
//  PostTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostTableViewCell: UITableViewCell {
    private let titleLabel = UILabel.autolayoutView()
    private let bodyLabel = UILabel.autolayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    func updateCell(withPost post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}

private extension PostTableViewCell {
    func setupViews() {
        accessoryType = .disclosureIndicator
        setupTitle()
        setupBody()
    }
    
    func setupTitle() {
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupBody() {
        bodyLabel.textColor = .black
        bodyLabel.textAlignment = .left
        bodyLabel.font = .systemFont(ofSize: 15)
        bodyLabel.numberOfLines = 0
        contentView.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
    }
}
