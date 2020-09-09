//
//  ECComicHeaderView.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/9/3.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECComicHeaderView: UIView {
    // MARK: ----------- lazyLoad
    private lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        bgView.isUserInteractionEnabled = false
        bgView.contentMode = .scaleAspectFill
        bgView.clipsToBounds = true
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .dark)
        let visualEffect: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        bgView.addSubview(visualEffect)
        visualEffect.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return bgView
    }()
    
    private lazy var coverView: UIImageView = {
       let coverView = UIImageView()
        coverView.contentMode = .scaleAspectFill
        coverView.layer.cornerRadius = 3
        coverView.layer.borderWidth = 1
        coverView.layer.borderColor = UIColor.white.cgColor
        return coverView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.white
        return nameLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 13)
        authorLabel.textColor = UIColor.white
        return authorLabel
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.textColor = UIColor.white
        totalLabel.font = UIFont.systemFont(ofSize: 13)
        return totalLabel
    }()
    
    private lazy var themeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 40, height: 20)
        layout.scrollDirection = .horizontal
        let themeCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        themeCV.dataSource = self
        themeCV.backgroundColor = UIColor.clear
        themeCV.showsHorizontalScrollIndicator = false
        themeCV.register(ComicHeaderThemeCell.self, forCellWithReuseIdentifier: NSStringFromClass(ComicHeaderThemeCell.self))
        return themeCV
    }()

    private var themeArr: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(bgView)
        bgView.addSubview(coverView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(authorLabel)
        bgView.addSubview(totalLabel)
        bgView.addSubview(themeCollectionView)
        
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        coverView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(90)
            $0.height.equalTo(120)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(coverView.snp.trailing).offset(20)
            $0.top.equalTo(coverView.snp.top)
            $0.trailing.greaterThanOrEqualToSuperview().offset(-20)
        }
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel)
            $0.right.greaterThanOrEqualToSuperview().offset(-20)
        }
        totalLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(authorLabel)
            make.trailing.greaterThanOrEqualToSuperview().offset(-20)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
        }
        themeCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(totalLabel)
            make.height.equalTo(30)
            make.trailing.greaterThanOrEqualToSuperview().offset(-20)
            make.bottom.equalTo(coverView)
        }
    }
    
    // MARK: ---------- setModel
    var detailStaticModel: ComicStaticModel? {
        didSet {
            guard let mDetailStaticModel = detailStaticModel else { return }
            bgView.kf.setImage(urlString: mDetailStaticModel.cover, placeholder: UIImage.init(named: "normal_placeholder_v"))
            coverView.kf.setImage(urlString: mDetailStaticModel.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            nameLabel.text = mDetailStaticModel.name ?? "惊叹之夜"
            authorLabel.text = mDetailStaticModel.author?.name ?? "图B"
            themeArr = mDetailStaticModel.theme_ids ?? ["老年", "热血"]
            themeCollectionView.reloadData()
        }
    }
    
    var detailRealtime: ComicRealtimeModel? {
        didSet {
            guard let mDetailRealtime = detailRealtime else { return }
            let text = NSMutableAttributedString(string: "点击 收藏")
            
            text.insert(NSAttributedString(string: "\(mDetailRealtime.click_total ?? "0")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]), at: 2);
            text.append(NSAttributedString(string: "\(mDetailRealtime.favorite_total ?? "0")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]))
            totalLabel.attributedText = text
        }
    }
}




extension ECComicHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ComicHeaderThemeCell.self), for: indexPath) as? ComicHeaderThemeCell
        cell?.titleLabel.text = themeArr?[indexPath.item]
        return cell!
    }
    
    
}

class ComicHeaderThemeCell: ECBaseCollectionViewCell {
     lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override func setupView() {
        self.contentView.layer.cornerRadius = 3
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.borderWidth = 1;
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

