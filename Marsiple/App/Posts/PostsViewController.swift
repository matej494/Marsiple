//
//  PostsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class PostsViewController: UIViewController {
    let viewModel: PostsViewModel
    private let postsView = PostsView.autolayoutView()
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupCallbacks()
        viewModel.fetchPosts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.postTableViewCell, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let viewModel = self.viewModel.viewModel(atIndexPath: indexPath)
        cell.update(viewModel)
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(atIndexPath: indexPath)
    }
}

private extension PostsViewController {
    func setupView() {
        title = LocalizationKey.Posts.navigationBarTitle.localized()
        view.backgroundColor = .white
        view.addSubview(postsView)
        postsView.tableView.dataSource = self
        postsView.tableView.delegate = self
        postsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupCallbacks() {
        viewModel.postCellViewModels.bind { [weak self] _ in
            self?.postsView.tableView.reloadData()            
        }
        viewModel.selectedPost.bind { [weak self] post in
            guard let post = post else { return }
            let postDetailsViewController = PostDetailsViewController(post: post)
            self?.navigationController?.pushViewController(postDetailsViewController, animated: true)
        }
    }
}
