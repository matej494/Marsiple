//
//  AlbumsViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class AlbumsViewController: UIViewController {
    private let albums = [Album](repeating: Album(images: [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4"), #imageLiteral(resourceName: "Image5"), #imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4")]), count: 10) // TODO: Popoulate with real data
    private lazy var photoCollectionViewControllers = populatePhotoCollectionViewControllers()
    private let albumsView = AlbumsView.autolayoutView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
    
    func populatePhotoCollectionViewControllers() -> [PhotoCollectionViewController] {
        var viewControllers = [PhotoCollectionViewController]()
        albums.forEach {
            let photoCollectionViewController = PhotoCollectionViewController(photos: $0.photos)
            viewControllers.append(photoCollectionViewController)
        }
        return viewControllers
    }
}
