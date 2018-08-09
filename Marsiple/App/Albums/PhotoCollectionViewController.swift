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
    
    init(albumId: Int) {
        self.albumId = albumId
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        MartianApiManager.getPhotos(albumId: albumId,
                              success: { [weak self] photos in
                                self?.photos = photos
                                self?.collectionView?.reloadData() },
                              failure: { error in
                                print(error.localizedDescription)
        })
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.updateCell(withURL: photos[indexPath.item].thumbnailUrl)
        return cell
    }
}

private extension PhotoCollectionViewController {
    func setupView() {
        setupCollectionView()
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
}
