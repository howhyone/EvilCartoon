//
//  ECComicDetailViewController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/8/7.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit
import JXPagingView
class ECComicDetailViewController: ECRootViewController {
    var listViewDidScrollCallBack: ((UIScrollView) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
    }
}

extension ECComicDetailViewController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return self.view
    }
    
    func listScrollView() -> UIScrollView {
        return UIScrollView.init()
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallBack = callback
    }
}
