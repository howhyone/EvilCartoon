//
//  ECRecommendCell.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/16.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit
/**漫画的cell*/
class ECRecommendCell: ECBaseCollectionViewCell {
    
    private lazy var coverView: UIImageView = {
        let coverView = UIImageView()
        coverView.contentMode = .scaleAspectFill
        coverView.clipsToBounds = true
        return coverView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.left
        return titleLabel
    }()
    
    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.textColor = UIColor.gray
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descLabel)
        
        descLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5 * scaleScreen)
            make.leading.equalToSuperview().offset(10 * scaleScreen)
            make.trailing.equalToSuperview().offset(-10 * scaleScreen)
            make.height.equalTo(20 * scaleScreen)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(descLabel.snp.top)
            make.leading.trailing.equalTo(descLabel);
            make.height.equalTo(25 * scaleScreen)
        }
        coverView.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top)
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    var recommentModel: ECRecommendModel? {
        didSet {
            guard let model = recommentModel else {
                return
            }
         print(model)
            
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model  else {
                return
            }
            coverView.kf.setImage(urlString: model.cover, placeholder: nil)
            descLabel.text = model.subTitle ?? "更新至\(model.content ?? "0")集"
            titleLabel.text = model.name ?? model.title
        }
    }
    
}

// 漫画类型cell
protocol ECRecommendTypeCellDelegate: class {
    func clickMoreAction(_ recommendTypeCell: ECRecommendTypeCell, moreAction button: UIButton)
}

typealias ECRecommendTypeCellClosure = () -> Void

class ECRecommendTypeCell: ECBaseCollectionViewCell {
    weak var delegate: ECRecommendTypeCellDelegate?
    private var moreActionClosure: ECRecommendTypeCellClosure?
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
    
    //MARK: ----------- setModel
    var model:ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconImageView.kf.setImage(urlString: model.cover, placeholder: nil)
            titleLabel.text = model.name
        }
    }
    

    @objc func clickMoreAction(button: UIButton) {
        delegate?.clickMoreAction(self, moreAction: button)
        guard let closure = moreActionClosure  else {
            return
        }
        closure()
    }
    
    //MARK: ----------- lazyLoad
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
