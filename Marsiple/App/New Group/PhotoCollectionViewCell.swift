//
//  PhotoCollectionViewCell.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCollectionViewCell {
    func updateCell(withImage image: UIImage) {
        imageView.image = image
    }
}

private extension PhotoCollectionViewCell {
    func setupImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
