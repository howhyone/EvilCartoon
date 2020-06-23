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
class ECHomeViewController: ECRootViewController {

    lazy var pagingView: JXPagingView = preferredPagingView()
    let dataSource: JxSegmented = value
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        
    }
    
    func preferredPagingView() -> JXPagingView {
        return JXPagingView(delegate: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
