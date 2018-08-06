//
//  TodoTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 26/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoTableViewCell: UITableViewCell {
    var didSelectCheckBox: (() -> Void)?
    private let todoLabel = UILabel.autolayoutView()
    private let checkBoxButton = UIButton.autolayoutView()
    
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
        checkBoxButton.isSelected = todo.completed
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
    @objc func checkBoxButtonPressed() {
        didSelectCheckBox?()
    }
}

private extension TodoTableViewCell {
    func setupViews() {
        setupTodoLabel()
        setupCheckBoxButton()
    }
    
    func setupTodoLabel() {
        contentView.addSubview(todoLabel)
        todoLabel.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview().inset(10) }
    }
    
    func setupCheckBoxButton() {
        checkBoxButton.setImage(#imageLiteral(resourceName: "checkbox-unselected"), for: .normal)
        checkBoxButton.setImage(#imageLiteral(resourceName: "checkbox-selected"), for: .selected)
        checkBoxButton.isSelected = false
        checkBoxButton.addTarget(self, action: #selector(checkBoxButtonPressed), for: .touchDown)
        contentView.addSubview(checkBoxButton)
        checkBoxButton.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        checkBoxButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(todoLabel.snp.trailing)
            $0.height.width.equalTo(20)
        }
    }
}
