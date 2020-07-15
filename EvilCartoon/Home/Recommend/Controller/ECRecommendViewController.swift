//
//  ECRecommendViewController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/6/30.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit
import JXPagingView
import LLCycleScrollView

class ECRecommendViewController: ECRootViewController {
    var listViewDidScrollCallback: ((UIScrollView) -> ())?

    private lazy var bannerView: LLCycleScrollView = {
        let bw = LLCycleScrollView()
        bw.backgroundColor = UIColor.white
        bw.autoScrollTimeInterval = 6;
        
        return bw;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ECRecommendViewController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return view
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    func listScrollView() -> UIScrollView {
        return UITableView.init()
    }

    func listWillAppear() {
        print("\(self.title ?? ""):\(#function)")
    }

    func listDidAppear() {
        print("\(self.title ?? ""):\(#function)")
    }

    func listWillDisappear() {
        print("\(self.title ?? ""):\(#function)")
    }

    func listDidDisappear() {
        print("\(self.title ?? ""):\(#function)")
    }
}
