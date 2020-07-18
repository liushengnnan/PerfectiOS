//
//  HomeBannerView.swift
//  MyProject
//
//  Created by shengnan liu on 18/7/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit
import FSPagerView

let imageUrl = "https://image.shutterstock.com/image-photo/various-asian-meals-on-rustic-260nw-1075946798.jpg"
let imageUrl2 = "https://image.freepik.com/free-psd/american-food-banner-template-design_23-2148473300.jpg"

class HomeBannerView: UIView {

    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.interitemSpacing = 10
        pagerView.automaticSlidingInterval = 2.0
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()

    lazy var pagerControl:FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.numberOfPages = imageUrls.count
        pageControl.contentHorizontalAlignment = .center
        pageControl.setStrokeColor(.white, for: .normal)
        pageControl.setStrokeColor(.gray, for: .selected)
        pageControl.setFillColor(.white, for: .normal)
        pageControl.setFillColor(.gray, for: .selected)
        pageControl.setPath(UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: 5, height: 5), cornerRadius: 4.0), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 8, height: 8)), for: .selected)
        return pageControl

    }()

    fileprivate let imageUrls = [imageUrl, imageUrl2, imageUrl, imageUrl2]

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        self.addSubview(pagerView)

        pagerView.snp.makeConstraints({ (make) in
            make.width.equalTo(ScreenWidth)
            make.height.equalToSuperview()
        })

        pagerView.addSubview(pagerControl)

        pagerControl.snp.makeConstraints({ (make) in
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(10)
            make.bottom.equalToSuperview().offset(-10)
        })
    }
}

extension HomeBannerView: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageUrls.count
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imageUrl = URL(string: self.imageUrls[index])
        cell.imageView?.kf.setImage(with: imageUrl)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pagerControl.currentPage = index
    }
}

extension HomeBannerView: FSPagerViewDelegate {

}
