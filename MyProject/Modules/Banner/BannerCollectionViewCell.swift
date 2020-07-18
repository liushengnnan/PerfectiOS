//
//  BannerCollectionViewCell.swift
//  MyProject
//
//  Created by shengnan liu on 18/7/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    var imageUrl: String? {
        didSet {
            guard let url = imageUrl else { return }
            image.kf.setImage(with: URL(string: url))
        }
    }

    var image: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: BannerCollectionViewCell
extension BannerCollectionViewCell {
    final private func setupUI() {
        image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer .masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)

        }
    }
}
