//
//  MYProgressHUD.swift
//  YiTuo_Swift
//
//  Created by 王飞 on 2018/1/4.
//  Copyright © 2018年 renywell. All rights reserved.
//

import UIKit
import SVProgressHUD
enum MYHudShowType: Int {
    case None = 0
    case Loaing = 1
    case Info = 2
}
class MYProgressHUD {
    // 单例
    static let share = MYProgressHUD()
    var showType:MYHudShowType = .None // 当前状态
    let showingMaxtime = 3.0  // 强展示时间
    var delayClossArr = Array<String>()
    private init(){}
    
    class func show(){
//        SVProgressHUD.show()
        print("---show")
        MYProgressHUD.share.showType = .Loaing
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.showLodingImg()
    }
//    SVProgressHUD.show(withStatus: "加载地图中...")
    class func show(withStatus: String){
        self.show()
    }
    class func showSuccess(withStatus: String){
//        MYProgressHUD.share.showType = .Info
//        SVProgressHUD.resetImg()
//        SVProgressHUD.showSuccess(withStatus: withStatus)
        SVProgressHUD.dismiss()
        Toast.share().makeText(withStatus, aDuration: Int32(2.5))
    }
    class func showError(withStatus: String){
//        MYProgressHUD.share.showType = .Info
//        SVProgressHUD.resetImg()
//        SVProgressHUD.showError(withStatus: withStatus)
        SVProgressHUD.dismiss()
        Toast.share().makeText(withStatus, aDuration: Int32(2.5))
    }
    class func showInfo(withStatus: String){
//        MYProgressHUD.share.showType = .Info
//        SVProgressHUD.resetImg()
//        SVProgressHUD.showInfo(withStatus: withStatus)
        SVProgressHUD.dismiss()
        Toast.share().makeText(withStatus, aDuration: Int32(2.5))
    }
    class func dismiss(){
//        if MYProgressHUD.share.showType == .Info {
//            MYProgressHUD.share.delayClossArr.append("d")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + MYProgressHUD.share.showingMaxtime) {
//                //code
//                MYProgressHUD.share.checkCanDissmiss()
//            }
//        } else {
//            MYProgressHUD.share.showType = .None
            SVProgressHUD.dismiss()
//        }
    }
    class func dismiss(withDelay: TimeInterval) -> Void {
        SVProgressHUD.dismiss(withDelay: withDelay)
    }
//    completion
    class func dismiss(withDelay: TimeInterval, completion: @escaping ()->Void) -> Void {
        SVProgressHUD.dismiss(withDelay: withDelay, completion:completion)
    }

    // 私有方法
    private func checkCanDissmiss(){
        if MYProgressHUD.share.delayClossArr.count > 1 {
            MYProgressHUD.share.delayClossArr.removeFirst()
            return
        }
        MYProgressHUD.share.delayClossArr.removeAll()
        if MYProgressHUD.share.showType == .Info {
            MYProgressHUD.share.showType = .None
            SVProgressHUD.dismiss()
        }
    }
    
}
