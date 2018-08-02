//
//  TodoTableViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 26/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoTableViewCell: UITableViewCell {
    weak var delegate: TodoTableViewCellDelegate?
    var indexPath = IndexPath()
    private let todoLabelContainerView = UIView.autolayoutView()
    private let checkBoxContainerView = UIView.autolayoutView()
    private let todoLabel = UILabel.autolayoutView()
    private let checkBoxImageView = UIImageView.autolayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupGestureRecognizers()
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
    @objc func titleTapped() {
        delegate?.tableViewCell(didSelectTitleAt: indexPath)
    }
    
    @objc func checkBoxTapped() {
        delegate?.tableViewCell(didSelectCheckBoxAt: indexPath)
    }
}

private extension TodoTableViewCell {
    func setupViews() {
        setupContainerViews()
        setupTodoLabel()
        setupCheckBoxImageView()
    }
    
    func setupContainerViews() {
        contentView.addSubview(todoLabelContainerView)
        todoLabelContainerView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        contentView.addSubview(checkBoxContainerView)
        checkBoxContainerView.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        checkBoxContainerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(todoLabelContainerView.snp.trailing)
        }
    }
    
    func setupTodoLabel() {
        todoLabelContainerView.addSubview(todoLabel)
        todoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func setupCheckBoxImageView() {
        checkBoxImageView.contentMode = .scaleAspectFit
        checkBoxImageView.clipsToBounds = true
        checkBoxImageView.image = #imageLiteral(resourceName: "checkbox-unselected")
        checkBoxContainerView.addSubview(checkBoxImageView)
        checkBoxImageView.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        checkBoxImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.height.width.equalTo(20)
        }
    }
    
    func setupGestureRecognizers() {
        let titleTap = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
        todoLabelContainerView.addGestureRecognizer(titleTap)
        todoLabelContainerView.isUserInteractionEnabled = true
        let checkBoxTap = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped))
        checkBoxContainerView.addGestureRecognizer(checkBoxTap)
        checkBoxContainerView.isUserInteractionEnabled = true
    }
}
