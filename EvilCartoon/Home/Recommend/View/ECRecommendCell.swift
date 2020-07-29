//
//  ECRecommendCell.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/16.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECRecommendCell: ECBaseCollectionViewCell {
    
    private lazy var coverView: UIImageView = {
        let coverView = UIImageView()
        coverView.backgroundColor = UIColor.green
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
//            coverView.kf.setImage(with: URL(string: model.cover ?? ""), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
            coverView.kf.setImage(with: URL(string: model.cover ?? ""))
            coverView.kf.setImage(with: <#T##Resource?#>, placeholder: <#T##Placeholder?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> Void#>, completionHandler: <#T##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##(Result<RetrieveImageResult, KingfisherError>) -> Void#>)
            descLabel.text = model.subTitle ?? "更新至\(model.content ?? "0")集"
            titleLabel.text = model.name ?? model.title
        }
    }
    
    
    
}
