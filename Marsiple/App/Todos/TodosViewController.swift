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
        cell.didSelectCheckBox = didSelectCheckBox(atIndexPath: indexPath)
        return cell
    }
}

extension TodosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoFormViewController = TodoFormViewController(todo: todos[indexPath.section][indexPath.row])
        todoFormViewController.todoCompletedIsEdited = didSelectCheckBox(atIndexPath: indexPath)
        todoFormViewController.todoTextIsEdited = didChangeText(atIndexPath: indexPath)
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
            tableView.performBatchUpdates({ tableView.deleteRows(at: [indexPath], with: .automatic) }
                , completion: nil)
        }
    }
}

private extension TodosViewController {
    @objc func addButtonTapped() {
        navigationController?.pushViewController(TodoFormViewController(), animated: true)
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
        todosView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    func didSelectCheckBox(atIndexPath indexPath: IndexPath) -> (() -> Void)? {
        let didSelectCheckBox = { [weak self] in
            // TODO: Save changes on the server
            guard let strongSelf = self
                else { return }
            
            let finishIndexPath = IndexPath(row: indexPath.section * strongSelf.todos[1 - indexPath.section].count, section: 1 - indexPath.section)
            var reloadTableView: (Bool) -> Void
            let rowsToReload = strongSelf.indexPathsAfter(indexPath: indexPath)
            if indexPath.section == 0 {
                reloadTableView = { [weak self] _ in
                    self?.todosView.tableView.reloadSections([finishIndexPath.section], with: .automatic)
                    self?.todosView.tableView.reloadRows(at: rowsToReload, with: .automatic)
                }
            } else {
                reloadTableView = { [weak self] _ in
                    self?.todosView.tableView.reloadRows(at: rowsToReload, with: .automatic)
                    self?.todosView.tableView.reloadRows(at: [finishIndexPath], with: .automatic)
                }
            }
            
            let removedTodo = strongSelf.todos[indexPath.section].remove(at: indexPath.row)
            removedTodo.completed = !removedTodo.completed
            strongSelf.todos[finishIndexPath.section].insert(removedTodo, at: finishIndexPath.row)
            strongSelf.todosView.tableView.performBatchUpdates({
                strongSelf.todosView.tableView.moveRow(at: indexPath, to: finishIndexPath)
            }, completion: reloadTableView)
        }
        return didSelectCheckBox
    }
    
    func indexPathsAfter(indexPath: IndexPath) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        let maxIndexOfTodos = todos[indexPath.section].count - 2
        guard indexPath.row <= maxIndexOfTodos else {
            return []
        }
        for i in indexPath.row...maxIndexOfTodos {
            indexPaths.append(IndexPath(row: i, section: indexPath.section))
        }
        return indexPaths
    }
    
    func didChangeText(atIndexPath indexPath: IndexPath) -> (() -> Void)? {
        return { [weak self] in
            self?.todosView.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
