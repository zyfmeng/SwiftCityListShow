//
//  FirstViewController.swift
//  CustomTabbar
//
//  Created by md on 16/6/20.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: BaseADViewController {
    
    var mTableView : UITableView!
    var mScrollView : UIScrollView!
    var headView: UIView!
    var totalArr : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
      

        //本地获取城市名称
        let defaults = NSUserDefaults.standardUserDefaults()
        let nameStr = defaults.stringForKey("CITY_NAME")
        if nameStr != nil {
             showCity(nameStr! as String)
        }else{
             showCity("城市")
        }
    }
    
    func showCity(cityName:String){
        //实现富文本
        var string: NSMutableAttributedString
        string = NSMutableAttributedString(string: cityName)
        
        //进行图文混排
        var textAttachment: NSTextAttachment
        textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named:"f_flagdown02@2x")
        textAttachment.bounds = CGRectMake(0, 0, 11,8);
        var textAttachmentString:NSAttributedString
        textAttachmentString = NSAttributedString(attachment: textAttachment)
//        //判断选择的城市名称长度是否大于5个字符的长度，如果大于五个字符就取前四个字符，然后再在最后添加一个图标
        if (string.length >= 5) {
            //去前四个字符
            var str: NSAttributedString
            str = NSAttributedString()
            str = string.attributedSubstringFromRange(NSMakeRange(0, 4))
            //将NSAttributedString类型转换成NSString类型
            let cityString:String = str.string;
            string = NSMutableAttributedString(string: "\(cityString)...")
        }
        
        //在城市名称后插入图片
        string.insertAttributedString(textAttachmentString, atIndex: string.length)
        
        //自定义按钮
        let btn = UIButton.init(type: UIButtonType.RoundedRect)
        btn.frame = CGRectMake(0, 0, 70, 30);
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action:#selector(navBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        let lbText: UILabel
        lbText = UILabel()
        lbText.frame = CGRectMake(0, 0, btn.frame.size.width+10, btn.frame.size.height)
        lbText.attributedText = string
        lbText.textColor = UIColor.whiteColor()
        lbText.font = UIFont.systemFontOfSize(13)
        btn.addSubview(lbText)
        btn.backgroundColor = UIColor.clearColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    //城市名称按钮触发事件
    func navBtnClick(){
        let citySelectVC = CitySelectViewController()
        citySelectVC.hidesBottomBarWhenPushed = true
        citySelectVC.cityNameBlock = {cityName,city_idStr in
            self.showCity(cityName)
        }
        self.navigationController?.pushViewController(citySelectVC, animated: true)
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
