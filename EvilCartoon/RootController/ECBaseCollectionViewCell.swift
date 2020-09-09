//
//  ECBaseCollectionViewCell.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/16.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECBaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() {
        
    }
}
