//
//  ECRootTabBarController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/6/17.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit

class ECRootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
        
        let homeVC: ECHomeViewController = ECHomeViewController.init()
        addChildViewController(homeVC, title: "首页", image: UIImage.init(named: "tab_home"), selectedImage: UIImage.init(named: "tab_home_S"))
        
        let categoryVC: ECCategoryViewController = ECCategoryViewController()
        addChildViewController(categoryVC, title: "分类", image: UIImage.init(named: "tab_class"), selectedImage: UIImage.init(named: "tab_class_S"))
        
        let bookshelf: ECBookshelfViewController = ECBookshelfViewController()
        addChildViewController(bookshelf, title: "书架", image: UIImage.init(named: "tab_book"), selectedImage: UIImage.init(named: "tab_book_S"))
        
        
        let mineVC: ECMineViewController = ECMineViewController()
        addChildViewController(mineVC, title: "我的", image: UIImage.init(named: "tab_mine"), selectedImage: UIImage.init(named: "tab_mine_S"))
        
    }
    
    func addChildViewController(_ childController: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) {
        childController.title = title;
        childController.tabBarItem = UITabBarItem(title: nil, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        addChild(UINavigationController(rootViewController: childController))
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
