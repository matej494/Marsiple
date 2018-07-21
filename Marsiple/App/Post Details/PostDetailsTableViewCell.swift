//
//  PostDetailsTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class PostDetailsTableViewCell: UITableViewCell {
    private let commentView = TitleAndBodyView.autolayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostDetailsTableViewCell {
    func updateProperties(email: String, body: String) {
        commentView.updateProperties(title: email, body: body)
    }
}

private extension PostDetailsTableViewCell {
    func setupViews() {
        contentView.addSubview(commentView)
        commentView.backgroundColor = .martianLightGrey
        commentView.titleLabelFontSize = 15
        commentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
