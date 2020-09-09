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
import HandyJSON
import Moya

class ECComicViewController: ECRootViewController {
    //MARK: ----------- 初始化参数
    var titleArr = ["详情", "目录", "讨论"]
    let headerHeight: Int = Int(navigationStatusBarHeight) + 150
    let pinSectionHeaderHeight = 30
    var hegiths: CGFloat = 0;
    private var comicId: Int = 0
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    
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
        pageView.pinSectionHeaderVerticalOffset = Int(navigationBarHeight + statusBarHeight)
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
    
    private lazy var headerView: ECComicHeaderView = {
        let headerView = ECComicHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navigationStatusBarHeight + 150))
        headerView.backgroundColor = .green
        return headerView
    }()

    // MARK: ----------- viewDidLoad
    convenience init(commicId: Int) {
        self.init()
        self.comicId = commicId;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hegiths = self.navigationController!.navigationBar.frame.size.height;

        self.setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController? .setNavigationBarHidden(false, animated: true)
        handleHttpRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.pageView)
        pageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
    
    // MARK: -----------HtppRequest
    func handleHttpRequest() {
        let group = DispatchGroup()
        group.enter()
        ApiLoadingProvider.request(UApi.detailStatic(comicid: comicId), model: DetailStaticModel.self) { (detailStatic) in
            self.detailStatic = detailStatic
            self.headerView.detailStaticModel = detailStatic?.comic
            
            group.leave()
        }
        
        group.enter()
        ApiProvider.request(UApi.detailRealtime(comicid: comicId), model: DetailRealtimeModel.self) { [weak self] (returnData) in
            self?.detailRealtime = returnData
            self?.headerView.detailRealtime = returnData?.comic
            
            group.leave()
        }
        
        group.enter()
//        ApiProvider.request(UApi.guessLike, model: guesslickmo, completion: <#T##((HandyJSON?) -> Void)?##((HandyJSON?) -> Void)?##(HandyJSON?) -> Void#>)
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
        
    }
}

extension ECComicViewController: UIScrollViewDelegate {
 
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
        comicDetailVC.delegate = self;
        return comicDetailVC
    }
        
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
         let alphaL = scrollView.contentOffset.y / (CGFloat(Int(navigationStatusBarHeight) + 150) - statusBarHeight - navigationBarHeight)
        self.navigationController?.barStyle(.theme)
        self.navigationController?.navigationBar.alpha = alphaL
        self.navigationItem.title = "吃人"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}

extension ECComicViewController: ECPagingScrollDelegate {
    func pagingScrollToTop() {
        self.pageView.mainTableView.contentOffset = .zero
    }
}

