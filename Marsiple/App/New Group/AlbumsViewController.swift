//
//  AlbumsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsViewController: UIViewController {
    private var albums = [Album]()
    private var photoCollectionViewControllers = [PhotoCollectionViewController]()
    private let albumsView = AlbumsView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        DataFetcher.getAlbums(success: { [weak self] albums in
                                self?.albums = albums
                                self?.albumsView.tableView.reloadData() },
                              failure: { error in
                                print(error.errorDescription) })
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
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if photoCollectionViewControllers.count <= indexPath.row {
            addPhotoCollectionViewController(index: indexPath.row)
        }
        cell.addSubview(photoCollectionViewControllers[indexPath.row].view)
        photoCollectionViewControllers[indexPath.row].view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.subviews.forEach { $0.removeFromSuperview() }
    }
}

private extension AlbumsViewController {
    func setupView() {
        title = "Albums"
        view.backgroundColor = .white
        view.addSubview(albumsView)
        albumsView.tableView.dataSource = self
        albumsView.tableView.delegate = self
        albumsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        albumsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func addPhotoCollectionViewController(index: Int) {
        let photoCollectionViewController = PhotoCollectionViewController(albumId: albums[index].id)
        photoCollectionViewControllers.append(photoCollectionViewController)
    }
}
