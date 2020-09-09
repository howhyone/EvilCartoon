//
//  ECComicDetailCell.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/9/9.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECComicDetailCell: UITableViewCell {

    // MARK: ----------- lazyLoad
    public lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupView()
    }
    
    func setupView() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView .addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adaptor(amount: 15))
            make.leading.equalToSuperview().offset(adaptor(amount: 15))
            make.trailing.equalToSuperview().offset(adaptor(amount: -15));
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//  作品介绍
class ECComitDetailDescribeCell: ECComicDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        self.titleLabel.text = "作品介绍"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//  其他作品
class ECComicDetailOtherCell: ECComicDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ECComicDetailMonthCell: ECComicDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    

    
    override func setupView() {
        super.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ECComicDetailLikeCell: ECComicDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override func setupView() {
        super.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
