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
import MJRefresh
import Moya
import HandyJSON

enum RequestType {
    case requestTypeInit
    case requestTypeMore
}

class ECRecommendViewController: ECRootViewController {
    
    fileprivate let bannerViewHeigh: CGFloat = screenWidth * 0.467
    let interItemSpacing: CGFloat = 8
    let sectionHeaderHeight: CGFloat = 44
    let sectionFooterHeight: CGFloat = 10

    var sexType: Int = UserDefaults.standard.integer(forKey: String.sexTypeKey)
    
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    private var galleryItemArr = [GalleryItemModel]()
    private var textItemArr = [TextItemModel]()
    /// cell的值
    private var comicLists = [ComicListModel]()
    
    private var recomendModel: ECRecommendModel = ECRecommendModel()
    
    private lazy var bannerView: LLCycleScrollView = {
        let bw = LLCycleScrollView()
        bw.backgroundColor = UIColor.white
        bw.autoScrollTimeInterval = 6;
        
        return bw;
    }()
    /// 漫画的collectionView
    private lazy var recommendCollectinView: UICollectionView = {
        let recommendFlowLayout = UICollectionViewFlowLayout()
        recommendFlowLayout.minimumLineSpacing = 0
        recommendFlowLayout.minimumInteritemSpacing = 8 * scaleScreen
        recommendFlowLayout.itemSize = CGSize(width: (screenWidth - 8 * scaleScreen)/2, height: 170 * scaleScreen)
        let recommendCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: recommendFlowLayout)
        recommendCV.backgroundColor = .white
        recommendCV.contentInset = UIEdgeInsets(top: bannerViewHeigh, left: 0, bottom: 0, right: 0)
        recommendCV.delegate = self
        recommendCV.dataSource = self
        recommendCV.register(ECRecommendCell.self, forCellWithReuseIdentifier: ECRecommendCell.description())
        recommendCV.register(ECRecommendTypeCell.self, forCellWithReuseIdentifier: ECRecommendTypeCell.description())
        recommendCV.register(ECRecommendReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ECRecommendReusableHeaderView.self))
        recommendCV.register(ECRecommendReusableFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ECRecommendReusableFooterView.description())
        recommendCV.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadDataSource(requestType: .requestTypeInit)
        })
        recommendCV.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.loadDataSource(requestType: .requestTypeMore)
        })
        return recommendCV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadDataSource(requestType: .requestTypeInit)
    }

    func setupView() {
        self.view.addSubview(recommendCollectinView)
        self.view.addSubview(bannerView)

        bannerView.snp.makeConstraints { (make) in
            make.height.equalTo(bannerViewHeigh)
            make.leading.trailing.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalToSuperview()
            }
        }
        recommendCollectinView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: ----------- httpRequst
    func loadDataSource(requestType:RequestType) {
        ApiLoadingProvider.request(UApi.boutiqueList(sexType: sexType), model: ECRecommendModel.self) { (responseData) in
            self.handleFooterView(requestType: requestType)
            self.recomendModel = responseData!
            self.galleryItemArr = responseData?.galleryItems ?? []
            self.textItemArr = responseData?.textItems ?? []
            self.comicLists = responseData?.comicLists ?? []
            self.recommendCollectinView.reloadData()
            self.bannerView.imagePaths = self.galleryItemArr.filter { $0.cover != nil }.map { $0.cover! }
        }
    }
    
    /// 处理footerView
    func handleFooterView(requestType: RequestType) {
        switch requestType {
        case .requestTypeInit:
            self.recommendCollectinView.mj_header?.endRefreshing()
        case .requestTypeMore:
            self.recommendCollectinView.mj_footer?.endRefreshing()
        }
    }
    
}

//MARK: -----------  UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout
extension ECRecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = comicLists[section]
        return comicList.comics?.prefix(4).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comicList = comicLists[indexPath.section]
        
        
       if comicList.comicType == .billboard {
            let cell: ECRecommendTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ECRecommendTypeCell.description(), for: indexPath) as! ECRecommendTypeCell
            cell.model = comicList.comics?[indexPath.row]
            return cell
        }else {
            if comicList.comicType == .thematic {
//                cell.style = .none
            } else {
//                cell.style = .withTitieAndDesc
            }
            let cell: ECRecommendCell = collectionView.dequeueReusableCell(withReuseIdentifier: ECRecommendCell.description(), for: indexPath) as! ECRecommendCell

            cell.model = comicList.comics?[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return comicLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let reusableHeaderView: ECRecommendReusableHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ECRecommendReusableHeaderView.self), for: indexPath) as! ECRecommendReusableHeaderView
            reusableHeaderView.model = comicLists[indexPath.section]
            return reusableHeaderView
        } else {
            let reusableFooterView: ECRecommendReusableFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ECRecommendReusableFooterView.description(), for: indexPath) as! ECRecommendReusableFooterView
            return reusableFooterView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: sectionHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return comicLists.count - 1 != section ? CGSize(width: screenWidth, height: sectionFooterHeight) : CGSize.zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == recommendCollectinView {
            self.bannerView.snp.updateConstraints { (make) in
                if #available(iOS 11, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(min(0, -(scrollView.contentOffset.y + bannerViewHeigh)))
                } else {
                    make.top.equalToSuperview().offset(min(bannerViewHeigh, -(scrollView.contentOffset.y + bannerViewHeigh)))
                }
            }
        }
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
        return self.recommendCollectinView
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
