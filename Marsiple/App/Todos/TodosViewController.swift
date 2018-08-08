//
//  TodosViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 26/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodosViewController: UIViewController {
    // TODO: Replace todos with real data
    private lazy var todos = setupTodos()
    private let todosView = TodosView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = todosView.tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell
            else { return UITableViewCell() }
        cell.updateProperties(withTodo: todos[indexPath.section][indexPath.row])
        cell.didSelectCheckBox = { [weak self] in
            self?.didSelectCheckBox(atIndexPath: indexPath)
        }
        return cell
    }
}

extension TodosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoFormViewController = TodoFormViewController(todo: todos[indexPath.section][indexPath.row])
        todoFormViewController.todoHandler = { [weak self] todo in self?.todoIsEdited(atIndexPath: indexPath, newValue: todo) }
        navigationController?.pushViewController(todoFormViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : LocalizationKey.Todos.completedSectionHeader.localized()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos[indexPath.section].remove(at: indexPath.row)
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: { _ in
                tableView.reloadData()
            })
        }
    }
}

private extension TodosViewController {
    @objc func addButtonTapped() {
        let todoFormViewController = TodoFormViewController()
        todoFormViewController.todoHandler = { [weak self] todo in self?.todoIsCreated(newTodo: todo) }
        navigationController?.pushViewController(todoFormViewController, animated: true)
    }
}

private extension TodosViewController {
    func setupView() {
        setupNavigationBar()
        title = LocalizationKey.Todos.navigationBarTitle.localized()
        view.backgroundColor = .white
        todosView.tableView.dataSource = self
        todosView.tableView.delegate = self
        todosView.tableView.estimatedRowHeight = 30
        view.addSubview(todosView)
        todosView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    // NOTE: This is just temporary, until network is implemented
    func setupTodos() -> [[Todo]] {
        var uncompleted = [Todo]()
        var completed = [Todo]()
        for i in 0...9 {
            uncompleted.append(Todo(id: i, title: "Todo \(0)\(i)", completed: false, userId: -1))
            completed.append(Todo(id: i, title: "Todo \(1)\(i)", completed: true, userId: -1))
        }
        return [uncompleted, completed]
    }
    
    func didSelectCheckBox(atIndexPath indexPath: IndexPath) {
        // TODO: Save changes on the server
        let finishIndexPath = IndexPath(row: indexPath.section * todos[1 - indexPath.section].count, section: 1 - indexPath.section)
        moveTodo(at: indexPath, to: finishIndexPath)
        moveRow(at: indexPath, to: finishIndexPath)
    }
    
    func moveTodo(at startIndexPath: IndexPath, to finishIndexPath: IndexPath) {
        var removedTodo = todos[startIndexPath.section].remove(at: startIndexPath.row)
        removedTodo.completed = !removedTodo.completed
        todos[finishIndexPath.section].insert(removedTodo, at: finishIndexPath.row)
    }
    
    func moveRow(at startIndexPath: IndexPath, to finishIndexPath: IndexPath) {
        todosView.tableView.performBatchUpdates({
            todosView.tableView.moveRow(at: startIndexPath, to: finishIndexPath)
        }, completion: { [weak self] _ in
            self?.todosView.tableView.reloadRows(at: [finishIndexPath], with: .automatic)
            self?.todosView.tableView.reloadData()
        })
    }

    func todoIsEdited(atIndexPath indexPath: IndexPath, newValue todo: Todo) {
        // TODO: Save changes on the server
        todos[indexPath.section][indexPath.row].title = todo.title
        if todos[indexPath.section][indexPath.row].completed != todo.completed {
            let finishIndexPath = IndexPath(row: indexPath.section * todos[1 - indexPath.section].count, section: 1 - indexPath.section)
            moveTodo(at: indexPath, to: finishIndexPath)
        }
        todosView.tableView.reloadData()
    }
    
    func todoIsCreated(newTodo todo: Todo) {
        // TODO: Save changes on the server
        todo.completed ? todos[1].insert(todo, at: 0) : todos[0].insert(todo, at: todos[0].count)
        todosView.tableView.reloadData()
    }
}
