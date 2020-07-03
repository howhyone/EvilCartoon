//
//  ECHomeViewController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/6/17.
//  Copyright © 2020 howhyone. All rights reserved.
//


import UIKit
import JXPagingView
import JXSegmentedView
import SnapKit
extension JXPagingListContainerView: JXSegmentedViewListContainer{}

class ECHomeViewController: ECRootViewController {

    lazy var pagingView: JXPagingView = preferredPagingView()
    lazy var dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(50)))
    var titleArr = ["推荐", "VIP", "订阅", "排行"];
    let headerHeigth: Int = 50;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin);
            } else  {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        dataSource.titles = titleArr
        dataSource.titleSelectedColor = UIColor.white
        dataSource.titleNormalColor = UIColor.init(white: 1, alpha: 0.3)
        segmentedView.backgroundColor = UIColor.green
        segmentedView.delegate = self
        segmentedView.dataSource = dataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        
        pagingView.mainTableView.gestureDelegate = self
        self.view.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
    }
    
    func preferredPagingView() -> JXPagingView {
        return JXPagingView(delegate: self)
    }

}


extension ECHomeViewController: JXPagingViewDelegate {
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 0
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return UIView.init()
    }
//    PinSectionHeader 存放title的view
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 50
    }

    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let recommendVC = ECRecommendViewController.init()
        return recommendVC;
        
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return 4
    }
}

extension ECHomeViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
    }
}


extension ECHomeViewController: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}
