//
//  TodoTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 26/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoTableViewCell: UITableViewCell {
    private let checkBoxImageView = UIImageView.autolayoutView()
    private let todoLabel = UILabel.autolayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoTableViewCell {
    func updateProperties(withTodo todo: Todo) {
        checkBoxImageView.image = todo.completed ? #imageLiteral(resourceName: "checkbox-selected") : #imageLiteral(resourceName: "checkbox-unselected")
        if todo.completed {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.title)
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            todoLabel.attributedText = attributeString
        } else {
            todoLabel.attributedText = nil
            todoLabel.text = todo.title
        }
    }
}

private extension TodoTableViewCell {
    func setupViews() {
        setupTodoLabel()
        setupCheckBoxImageView()
    }
    
    func setupTodoLabel() {
        contentView.addSubview(todoLabel)
        todoLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setupCheckBoxImageView() {
        checkBoxImageView.contentMode = .scaleAspectFit
        checkBoxImageView.clipsToBounds = true
        checkBoxImageView.image = #imageLiteral(resourceName: "checkbox-unselected")
        contentView.addSubview(checkBoxImageView)
        checkBoxImageView.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        checkBoxImageView.snp.makeConstraints {
            $0.leading.equalTo(todoLabel.snp.trailing).inset(10)
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.height.width.equalTo(20)
        }
    }
}
