//
//  TodoFormViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 31/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoFormViewController: UIViewController {
    // NOTE: id is set to -1 so we can detect if we're creating new or changing existing todo (to detect wich initializer is used)
    private var todo = Todo(id: -1, title: "", completed: false, userId: 1)
    private let todoFormView = TodoFormView.autolayoutView()
    private lazy var completedButton: UIButton = {
        let button = UIButton()
        let image = todo.completed ? #imageLiteral(resourceName: "checkbox-selected") : #imageLiteral(resourceName: "checkbox-unselected")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(completedButtonTapped), for: .touchDown)
        button.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    init(todo: Todo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TodoFormViewController {
    @objc func completedButtonTapped() {
        todo.completed = !todo.completed
        let image = todo.completed ? #imageLiteral(resourceName: "checkbox-selected") : #imageLiteral(resourceName: "checkbox-unselected")
        completedButton.setImage(image, for: .normal)
    }
    
    @objc func backButtonTapped() {
        // TODO: Save changes on the server
        todo.title = todoFormView.text
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonTapped))
    }
    
    func setupFormView() {
        todoFormView.placeholder = todo.title
        view.addSubview(todoFormView)
        todoFormView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
