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

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
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
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}

extension TodosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : LocalizationKey.Todos.completedSectionHeader.localized()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension TodosViewController: TodoTableViewCellDelegate {
    func tableViewCell(didSelectTitleAt indexPath: IndexPath) {
        navigationController?.pushViewController(TodoFormViewController(todo: todos[indexPath.section][indexPath.row]), animated: true)
    }

    func tableViewCell(didSelectCheckBoxAt indexPath: IndexPath) {
        // TODO: Save changes on the server
        let finishIndexPath = IndexPath(row: todos[1 - indexPath.section].count, section: 1 - indexPath.section)
        todosView.tableView.performBatchUpdates({
            let removedTodo = todos[indexPath.section].remove(at: indexPath.row)
            removedTodo.completed = !removedTodo.completed
            todos[finishIndexPath.section].insert(removedTodo, at: finishIndexPath.row)
            todosView.tableView.moveRow(at: indexPath, to: finishIndexPath) },
                                      completion: { [weak self] _ in self?.todosView.tableView.reloadData() })
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
    
    func reloadData() {
        let newlyCompleted = todos[TodosIndex.uncompleted.rawValue].filter { $0.completed }
        if !newlyCompleted.isEmpty {
            todos[TodosIndex.uncompleted.rawValue] = todos[TodosIndex.uncompleted.rawValue].filter { $0.completed == false }
            todos[TodosIndex.completed.rawValue] += newlyCompleted
        }
        let newlyUncompleted = todos[TodosIndex.completed.rawValue].filter { $0.completed == false }
        if !newlyUncompleted.isEmpty {
            todos[TodosIndex.completed.rawValue] = todos[TodosIndex.completed.rawValue].filter { $0.completed }
            todos[TodosIndex.uncompleted.rawValue] += newlyUncompleted
        }
        todosView.tableView.reloadData()
    }
}
