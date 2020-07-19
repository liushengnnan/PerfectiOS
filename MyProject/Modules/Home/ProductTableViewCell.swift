//
//  ProductTableViewCell.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
class ProductTableViewCell: TableViewCell {

    lazy var productImageView: ImageView = {
        let view = ImageView(frame: CGRect())
        view.contentMode = .scaleAspectFit
        view.cornerRadius = 25
        view.snp.makeConstraints({ (make) in
            make.size.equalTo(ScreenWidth - 32)
        })
        return view
    }()

    lazy var titleLabel: Label = {
        let view = Label()
        view.font = view.font.withSize(14)
        return view
    }()

    lazy var detailLabel: Label = {
        let view = Label()
        view.font = view.font.withSize(12)
        view.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return view
    }()

    lazy var secondDetailLabel: Label = {
        let view = Label()
        view.font = view.font.bold.withSize(11)
        return view
    }()

    lazy var textsStackView: StackView = {
        let views: [UIView] = [self.titleLabel, self.secondDetailLabel]
        let view = StackView(arrangedSubviews: views)
        view.spacing = 2
        return view
    }()

    lazy var followButton: Button = {
        let view = Button()
        view.borderColor = .white
        view.borderWidth = Configs.BaseDimensions.borderWidth
        view.tintColor = .white
        view.cornerRadius = 17
        view.snp.remakeConstraints({ (make) in
            make.width.equalTo(100)
            make.height.equalTo(34)
        })
        return view
    }()

    lazy var detailStackView: StackView = {
        let views: [UIView] = [self.detailLabel, self.followButton]
        let view = StackView(arrangedSubviews: views)
        view.alignment = .fill
        view.axis = .horizontal
        return view
    }()

    override func makeUI() {
        super.makeUI()

        themeService.rx
            .bind({ $0.text }, to: titleLabel.rx.textColor)
            .bind({ $0.textGray }, to: detailLabel.rx.textColor)
            .bind({ $0.text }, to: secondDetailLabel.rx.textColor)
            .bind({ $0.secondary }, to: productImageView.rx.tintColor)
            .disposed(by: rx.disposeBag)

        stackView.addArrangedSubview(productImageView)
        stackView.addArrangedSubview(textsStackView)
        stackView.addArrangedSubview(detailStackView)
        stackView.snp.remakeConstraints({ (make) in
            let inset = self.inset
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: inset/2, left: inset, bottom: inset/2, right: inset))
            make.height.greaterThanOrEqualTo(Configs.BaseDimensions.tableRowHeight)
        })
    }

    override func bind(to viewModel: TableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? ProductCellViewModel else { return }

        viewModel.title.asDriver().drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.title.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(titleLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.detail.asDriver().drive(detailLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.detail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(detailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.secondDetail.asDriver().drive(secondDetailLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.secondDetail.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(secondDetailLabel.rx.isHidden).disposed(by: rx.disposeBag)

        viewModel.imageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(productImageView.rx.imageURL).disposed(by: rx.disposeBag)

        viewModel.imageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.productImageView.hero.id = url
            }).disposed(by: rx.disposeBag)

        viewModel.isCarted.asDriver().map { (followed) -> String? in
            let title = followed ? viewModel.product.price : "added +1"
            return title
            }.drive(followButton.rx.title()).disposed(by: rx.disposeBag)
        viewModel.isCarted.map { $0 ? 1.0: 0.6 }.asDriver(onErrorJustReturn: 0).drive(followButton.rx.alpha).disposed(by: rx.disposeBag)
    }
    
}
