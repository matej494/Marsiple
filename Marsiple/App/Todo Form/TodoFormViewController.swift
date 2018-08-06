//
//  TodoFormViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 31/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoFormViewController: UIViewController {
    var todoTextIsEdited: (() -> Void)?
    var todoCompletedIsEdited: (() -> Void)?
    private var todo: Todo
    private let isEditingTodo: Bool
    private let todoFormView = TodoFormView.autolayoutView()
    private lazy var completedButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "checkbox-unselected"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "checkbox-selected"), for: .selected)
        button.isSelected = todo.completed
        button.addTarget(self, action: #selector(completedButtonTapped), for: .touchDown)
        button.snp.makeConstraints { $0.width.height.equalTo(30) }
        return button
    }()
    
    init(todo: Todo? = nil) {
        if let todo = todo {
            self.todo = todo
            isEditingTodo = true
        } else {
            self.todo = Todo(id: -1, title: "", completed: false, userId: -1)
            isEditingTodo = false
        }
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TodoFormViewController {
    @objc func completedButtonTapped() {
        completedButton.isSelected = !completedButton.isSelected
    }
    
    @objc func doneButtonTapped() {
        // TODO: Save changes on the server
        if isEditingTodo {
            if todo.completed != completedButton.isSelected {
                todo.title = todoFormView.text
                todoCompletedIsEdited?()
            } else if todo.title != todoFormView.text {
                todo.title = todoFormView.text
                todoTextIsEdited?()
            }
        } else {
            // TODO: Save new todo
        }
        navigationController?.popViewController(animated: true)
    }
}

private extension TodoFormViewController {
    func setupView() {
        view.backgroundColor = .white
        hidesBottomBarWhenPushed = true
        setupNavigationBar()
        setupFormView()
    }
    
    func setupNavigationBar() {
        navigationItem.title = LocalizationKey.TodoForm.navigationBarTitle.localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completedButton)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    func setupFormView() {
        todoFormView.placeholder = todo.title
        view.addSubview(todoFormView)
        todoFormView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
}
