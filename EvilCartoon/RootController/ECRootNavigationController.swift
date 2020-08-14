//
//  ECRootNavigationController.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/8/11.
//  Copyright © 2020 howhyone. All rights reserved.
//

import UIKit



class ECRootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}

enum ECNavigationBarType {
    case theme
    case clear
    case white
}
extension UINavigationController {
    func barStyle(_ style: ECNavigationBarType) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true

        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = nil
        
        }
    }
}
