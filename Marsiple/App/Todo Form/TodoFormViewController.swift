//
//  TodoFormViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 31/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoFormViewController: UIViewController {
    var todoHandler: ((Todo) -> Void)?
    private let isEditingTodo: Bool
    private let originalTodo: Todo
    private var todo: Todo
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
        self.todo = todo ?? Todo(id: -1, title: "", completed: false, userId: 2)
        self.originalTodo = self.todo
        self.isEditingTodo = todo != nil
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
        completedButton.isSelected = todo.completed
    }
    
    @objc func doneButtonTapped() {
        todo.title = todoFormView.title
        if originalTodo == todo || todo.title.isEmpty {
            navigationController?.popViewController(animated: true)
        } else if isEditingTodo {
            MartianApiManager<Todo>.patchData(data: todo,
                                              success: { [weak self] message in
                                                self?.success(message: message) },
                                              failure: { [weak self] error in
                                                self?.failure(error: error)
            })
        } else {
            MartianApiManager<Todo>.postData(data: todo,
                                             success: { [weak self] message in
                                                self?.success(message: message) },
                                             failure: { [weak self] error in
                                                self?.failure(error: error)
            })
        }
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
        todoFormView.title = todo.title
        view.addSubview(todoFormView)
        todoFormView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
    func success(message: String) {
        let alert = UIAlertController
            .alertStyle(title: LocalizationKey.TodoForm.successAlertTitle.localized(),
                        message: LocalizationKey.Alert.successAlertMessage.localized(message),
                        cancelActionTitle: LocalizationKey.Alert.okAlertAction.localized(),   
                        cancelActionHandler: { [weak self] _ in
                            self?.todoHandler?((self?.todo)!)
                            self?.navigationController?.popViewController(animated: true)
            })
        present(alert, animated: true, completion: nil)
    }
    
    func failure(error: LocalizedError) {
        let message = error.localizedDescription
        let alert = UIAlertController
            .alertStyle(title: LocalizationKey.Alert.failureAlertTitle.localized(),
                        message: LocalizationKey.Alert.failureAlertMessage.localized(message),
                        cancelActionTitle: LocalizationKey.Alert.cancelAlertAction.localized(),
                        cancelActionHandler: { [weak self] _ in
                            self?.navigationController?.popViewController(animated: true)
            })
        alert.addAction(UIAlertAction(title: LocalizationKey.Alert.stayHereAlertAction.localized(),   
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
