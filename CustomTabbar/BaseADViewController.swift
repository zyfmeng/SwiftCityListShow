//
//  BaseADViewController.swift
//  CustomTabbar
//
//  Created by md on 16/6/20.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit

class BaseADViewController: UIViewController {

    
    //带有菊花的提示
    var hub = MBProgressHUD()
    func startLoading(){
        hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.labelText = "正在加载..."
    }
    func stopLoading() {
        hub.hide(true)
    }
    func showMsg(msg : String) {
        hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.labelText = msg
        hub.dimBackground = true
        hub.hide(true, afterDelay: 2)
    }
    //纯文本提示含标题和详情信息
    func showTextMsg(title:String,content:String){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeText
        hud.labelText = title
        hud.detailsLabelText = content
        
        //延迟隐藏
        hud.hide(true, afterDelay: 2)
    }
    //自定义视图提示
    func showCustomMsg(){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeCustomView
        hud.customView = UIImageView(image: UIImage(named: "banner02"))
        hud.labelText = "快点跑"
        hud.hide(true, afterDelay: 2)
    }
    //使用异步功能
    func showAsyncMsg(){
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍等，数据加载中,预计10秒中"
        
        hud.showAnimated(true, whileExecutingBlock: {
            //异步任务，在后台运行的任务
            sleep(10)
        }) {
            //执行完成后的操作，移除
            hud.removeFromSuperview()
            hud = nil
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "f_navtop"), forBarMetrics: .Default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
