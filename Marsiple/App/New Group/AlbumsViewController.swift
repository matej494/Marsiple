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

private extension AlbumsViewController {
    func setupView() {
        title = "Albums"
        view.backgroundColor = .white
        view.addSubview(albumsView)
        albumsView.updateData(withAlbums: albums)
        albumsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Albums"
    }
}
