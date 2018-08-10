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
    private lazy var todos = [[Todo]]()
    private let todosView = TodosView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTodos()
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
        return cell
    }
}

extension TodosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let finishIndexPath = IndexPath(row: indexPath.section * todos[1 - indexPath.section].count, section: 1 - indexPath.section)
        var removedTodo = todos[indexPath.section].remove(at: indexPath.row)
        removedTodo.completed = !removedTodo.completed
        todos[finishIndexPath.section].insert(removedTodo, at: finishIndexPath.row)
        tableView.performBatchUpdates({
            tableView.moveRow(at: indexPath, to: finishIndexPath)
        }, completion: { _ in
            tableView.reloadRows(at: [finishIndexPath], with: .automatic)
        })
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
            }, completion: nil)
        }
    }
}

private extension TodosViewController {
    func setupView() {
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
    
    func setupTodos() {
        // NOTE: userId is used so app is testable (if all todos are downloaded it would be hard to see what's happening)
        MartianApiManager.getTodos(userId: 2,
                                   success: { [weak self] todos in
                                    self?.todos.append(todos.filter({ $0.completed == false }))
                                    self?.todos.append(todos.filter({ $0.completed }))
                                    self?.todosView.tableView.reloadData() },
                                   failure: { error in
                                    print(error.localizedDescription)
        })
    }
}
