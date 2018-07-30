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
        return cell
    }
}

extension TodosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var removedTodo = todos[indexPath.section].remove(at: indexPath.row)
        removedTodo.completed = !removedTodo.completed
        todos[1 - indexPath.section].insert(removedTodo, at: todos[1 - indexPath.section].count)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : LocalizationKey.Todos.completedSectionHeader.localized()
    }
}

private extension TodosViewController {
    func setupView() {
        title = LocalizationKey.Todos.navigationBarTitle.localized()
        view.backgroundColor = .white
        todosView.tableView.dataSource = self
        todosView.tableView.delegate = self
        view.addSubview(todosView)
        todosView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTodos() -> [[Todo]] {
        let uncompleated = [Todo](repeating: Todo(id: 1, title: "Todo 1", completed: false, userId: 1), count: 10)
        let compleated = [Todo](repeating: Todo(id: 1, title: "Todo 2", completed: true, userId: 1), count: 10)
        return [uncompleated, compleated]
    }
}
