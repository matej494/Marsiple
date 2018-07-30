//
//  AlbumsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsViewController: UIViewController {
    private var albums = [Album]() {
        didSet { photoCollectionViewControllers = albums.map { PhotoCollectionViewController(albumId: $0.id) } }
    }
    private var photoCollectionViewControllers = [PhotoCollectionViewController]()
    private let albumsView = AlbumsView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        DataFetcher.getAlbums(success: { [weak self] albums in
                                self?.albums = albums
                                self?.albumsView.tableView.reloadData() },
                              failure: { error in print(error.errorDescription) })
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoCollectionViewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as UITableViewCell
        cell.addSubview(photoCollectionViewControllers[indexPath.row].view)
        photoCollectionViewControllers[indexPath.row].view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return cell
    }
}

private extension AlbumsViewController {
    func setupView() {
        title = "Albums"
        view.backgroundColor = .white
        view.addSubview(albumsView)
        albumsView.tableView.dataSource = self
        albumsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        albumsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
