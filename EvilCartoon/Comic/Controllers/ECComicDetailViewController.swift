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
    var DetailVCDidScrollCallBack: ((UIScrollView) -> ())?
    weak var delegate: ECPagingScrollDelegate?
    
    private lazy var detailTableView: UITableView = {
        let detailTableView: UITableView = UITableView.init(frame: .zero, style: .grouped)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(ECComitDetailDescribeCell.self, forCellReuseIdentifier: reuseIdentifier(cell: ECComitDetailDescribeCell.self))
        detailTableView.register(ECComicDetailOtherCell.self, forCellReuseIdentifier: reuseIdentifier(cell: ECComicDetailOtherCell.self))
        detailTableView.register(ECComicDetailMonthCell.self, forCellReuseIdentifier: reuseIdentifier(cell: ECComicDetailMonthCell.self))
        detailTableView.register(ECComicDetailLikeCell.self, forCellReuseIdentifier: reuseIdentifier(cell: ECComicDetailLikeCell.self))
        return detailTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.detailTableView)
        detailTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func reuseIdentifier(cell:AnyObject) -> String! {
        return NSStringFromClass(cell.self as! AnyClass)
    }
}

extension ECComicDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(cell: ECComitDetailDescribeCell.self), for: indexPath) as! ECComitDetailDescribeCell
            return cell
        case 1:
            let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(cell: ECComicDetailOtherCell.self), for: indexPath) as! ECComicDetailOtherCell
            return cell
        case 2:
            let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(cell: ECComicDetailMonthCell.self), for: indexPath) as! ECComicDetailMonthCell
            return cell
        case 3:
            let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(cell: ECComicDetailLikeCell.self), for: indexPath) as! ECComicDetailLikeCell
            return cell
        default:
            let cell:UITableViewCell = UITableViewCell()
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.DetailVCDidScrollCallBack != nil) {
            self.DetailVCDidScrollCallBack!(scrollView)
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        self.detailTableView.contentOffset = .zero
        self.delegate?.pagingScrollToTop()
        return false
    }
}

protocol ECPagingScrollDelegate: class {
    func pagingScrollToTop()
}


extension ECComicDetailViewController: JXPagingViewListViewDelegate {
    func listView() -> UIView {
        return self.view
    }
    
    func listScrollView() -> UIScrollView {
        return self.detailTableView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.DetailVCDidScrollCallBack = callback
    }
}
