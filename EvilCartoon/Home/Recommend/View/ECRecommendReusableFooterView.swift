//
//  ECRecommendReusableFooterView.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/8/3.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECRecommendReusableFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
