//
//  PhotoCollectionViewController.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    private let albumId: Int
    private var photos = [Photo]()
    private var thumbnails = [UIImage]()
    private let activityIndicatorView = UIActivityIndicatorView.autolayoutView()
    
    init(albumId: Int) {
        self.albumId = albumId
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        DataFetcher.getPhotos(albumId: albumId, success: { [weak self] photos in
                                self?.photos = photos
                                self?.downloadThumbnails() },
                              failure: { error in
                                print(error.errorDescription) })
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.updateCell(withImage: thumbnails[indexPath.item])
        return cell
    }
}

private extension PhotoCollectionViewController {
    func setupView() {
        setupCollectionView()
        setupActivityIndicatorView()
    }
    
    func setupCollectionView() {
        self.collectionView!.backgroundColor = .white
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func setupActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func downloadThumbnails() {
        let group = DispatchGroup()
        photos.forEach { photo in
            group.enter()
            DataFetcher.getThumbnail(withUrl: photo.thumbnailUrl,
                                          success: { [weak self] image in
                                            self?.thumbnails.append(image)
                                            group.leave() },
                                          failure: { error in
                                            print(error.errorDescription)
                                            group.leave() })
        }
        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.removeFromSuperview()
            self?.collectionView?.reloadData()
        }
    }
}
