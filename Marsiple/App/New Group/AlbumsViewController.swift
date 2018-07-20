//
//  AlbumsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsViewController: UIViewController {
    private let albums = [Album](repeating: Album(images: [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4"), #imageLiteral(resourceName: "Image5"), #imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4")]), count: 10)
    private let albumsView = AlbumsView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
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
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as UITableViewCell
        let photoCollectionView = PhotoCollectionViewController(photos: albums[indexPath.row].photos)
        cell.addSubview(photoCollectionView.view)
        photoCollectionView.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(70)
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
    
    func setupNavigationBar() {
        navigationItem.title = "Albums"
    }
}
