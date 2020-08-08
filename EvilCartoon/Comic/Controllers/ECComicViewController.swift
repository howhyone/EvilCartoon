//
//  ECComicViewController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/8/6.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXPagingView
class ECComicViewController: ECRootViewController {
    //MARK: ----------- lazyLoad
    
    private lazy var segmentedView:  JXSegmentedView = {
        let segment = JXSegmentedView()
        segment.delegate = self
        segment.dataSource = self.dataSource
        segment.isContentScrollViewClickTransitionAnimationEnabled = false
        segment.listContainer = self.pageView.listContainerView
        segment.indicators = [self.indicatorView]
       
        return segment
    }()
    
    private lazy var pageView:JXPagingListRefreshView = {
        let pageView = JXPagingListRefreshView(delegate: self, listContainerType: JXPagingListContainerType.collectionView)
        return pageView
    }()
    
    private lazy var dataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = self.titleArr
        dataSource.titleSelectedColor = UIColor.init(r: 127, g: 221, b: 146)
        dataSource.titleNormalColor = UIColor.black
        
        return dataSource
    }()
    
    private lazy var indicatorView: JXSegmentedIndicatorLineView = {
        let indicatorView = JXSegmentedIndicatorLineView()
        indicatorView.indicatorColor = UIColor(r: 127, g: 221, b: 146)
        indicatorView.indicatorWidth = 20
        return indicatorView
    }()
    
    private lazy var headerView: UIView = {
        let headerView = UIView.init()
        headerView.backgroundColor = .green
        return headerView
    }()
    
    //MARK: ----------- 初始化参数
    var titleArr = ["详情", "目录", "讨论"]
    let headerHeight: Int = Int(navigationBarY) + 150
    let pinSectionHeaderHeight = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController? .setNavigationBarHidden(false, animated: true)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.pageView)
        pageView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalToSuperview()
            }
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
}

extension ECComicViewController: JXSegmentedViewDelegate {
    
}

extension ECComicViewController: JXPagingViewDelegate {
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return headerHeight
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return self.headerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return pinSectionHeaderHeight
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titleArr.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let comicDetailVC: ECComicDetailViewController = ECComicDetailViewController()
        return comicDetailVC
    }
}

//extension ECComicViewController: jxpagdele
