//
//  Global.swift
//  EvilCartoon
//
//  Created by fd-macmini on 2020/7/20.
//  Copyright © 2020 howhyone. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh
import HandyJSON

extension UIColor {
    class var background: UIColor {
        return UIColor.init(r: 242, g: 242, b: 242)
    }
    
    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
}

extension String {
    static let sexTypeKey = "sexTypeKey"
    static let searchHistoryKey = "searchHistoryKey"
}

extension KingfisherWrapper where Base: KFCrossPlatformImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> DownloadTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])!
        
    }
}

extension Array: HandyJSON{}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message: String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let scaleScreen = 375/screenWidth

/// 获取当前控制器
var topVC: UIViewController? {
    var resultVC: UIViewController?
    DispatchQueue.main.async {
        resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else if ((vc?.presentedViewController) != nil) {
        return _topVC(vc?.presentedViewController)
    } else {
        return vc ?? UIViewController()
    }
 
}

/// data转json
func DataToJSONObject(data: Data) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data , options: .mutableContainers) as AnyObject;
    } catch {
        print(error);
    }
    return nil;
}

/// 网络图片赋值

