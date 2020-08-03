//
//  ECRecommendReusableHeaderView.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/21.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

typealias ECRecommendHeaderClosure = () -> Void

protocol ECRecommendReuasbleHeaderDelegate: class {
    func clickMoreAction(_ recommendReusableHeader: ECRecommendReusableHeaderView, moreAction button: UIButton)
}

class ECRecommendReusableHeaderView: UICollectionReusableView {
    
    weak var delegate: ECRecommendReuasbleHeaderDelegate?
    private var moreActionClosure: ECRecommendHeaderClosure?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(moreBtn)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scaleScreen * 5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40 * scaleScreen)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(scaleScreen * 5)
            make.centerY.equalTo(iconImageView)
            make.width.equalTo(200 * scaleScreen)
        }
        moreBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(40 * scaleScreen)
        }
    }

    @objc func clickMoreAction(button: UIButton) {
        delegate?.clickMoreAction(self, moreAction: button)
        guard let closure = moreActionClosure  else {
            return
        }
        closure()
    }
    
    //MARK: ----------- setModel
    var model: ComicListModel? {
     
        didSet {
            guard let model = model else {
                return
            }
            iconImageView.kf.setImage(urlString: model.newTitleIconUrl, placeholder: nil)
            titleLabel.text = model.itemTitle
        }
    }
    
    
    //MARK: ----------- lazy load
    private lazy var iconImageView: UIImageView = {
        let iconImageView: UIImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        return iconImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var moreBtn: UIButton = {
        let moreBtn = UIButton(type: .system)
        moreBtn.setTitle("•••", for: .normal)
        moreBtn.setTitleColor(UIColor.lightGray, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moreBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
        return moreBtn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
