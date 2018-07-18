//
//  PostTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostTableViewCell: UITableViewCell {
    private let title = UILabel.autolayoutView()
    private let body = UILabel.autolayoutView()
    
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
        title.text = post.title
        body.text = post.body
    }
}

private extension PostTableViewCell {
    func setupViews() {
        accessoryType = .disclosureIndicator
        backgroundColor = .martianLightGrey
        setupTitle()
        setupBody()
    }
    
    func setupTitle() {
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20)
        contentView.addSubview(title)
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupBody() {
        body.textColor = .black
        body.textAlignment = .left
        body.font = .systemFont(ofSize: 15)
        body.numberOfLines = 0
        contentView.addSubview(body)
        body.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
            $0.top.equalTo(title.snp.bottom).inset(-10)
        }
    }
}
