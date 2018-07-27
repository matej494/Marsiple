//
//  PostView.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class TitleAndBodyView: UIView {
    var titleLabelFontSize: CGFloat = 20 {
        didSet { titleLabel.font = .systemFont(ofSize: titleLabelFontSize) }
    }
    
    var bodyLabelFontSize: CGFloat = 15 {
        didSet { bodyLabel.font = .systemFont(ofSize: bodyLabelFontSize) }
    }
    
    private let titleLabel = UILabel.autolayoutView()
    private let bodyLabel = UILabel.autolayoutView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleAndBodyView {
    func updateProperties(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
}

private extension TitleAndBodyView {
    func setupViews() {
        backgroundColor = .martianLightGrey
        setupTitle()
        setupBody()
    }
    
    func setupTitle() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: titleLabelFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupBody() {
        addSubview(bodyLabel)
        bodyLabel.textColor = .black
        bodyLabel.textAlignment = .left
        bodyLabel.font = .systemFont(ofSize: bodyLabelFontSize)
        bodyLabel.numberOfLines = 0
        bodyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(bodyLabelFontSize)
            $0.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
    }
}
