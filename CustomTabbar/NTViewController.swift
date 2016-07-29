//
//  NTViewController.swift
//  CustomTabbar
//
//  Created by md on 16/6/20.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit

class NTViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //.创建首页导航控制器
        let firstVC=FirstViewController();
        let nav1=UINavigationController(rootViewController: firstVC);
//        navIndex.title="首页";
        nav1.tabBarItem.title = "首页"
        nav1.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Selected)
        //tabbar_home
        nav1.tabBarItem.image = UIImage(named: "tabbar_home")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal); //默认显示图片
        nav1.tabBarItem.selectedImage = UIImage(named: "tabbar_home_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal); //选中后的图片
        //.创建活动信息导航控制器
        let secondVC = SecondViewController();
        let nav2 = UINavigationController(rootViewController: secondVC);
        nav2.title = "活动信息";
        nav2.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Selected)
        nav2.tabBarItem.image = UIImage(named: "tabbar_message_center")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        nav2.tabBarItem.selectedImage = UIImage(named: "tabbar_message_center_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        //.创建车辆展示导航控制器
        let ThirdVC = ThirdViewController();
        let nav3 = UINavigationController(rootViewController: ThirdVC);
        nav3.title = "搜索";
        nav3.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Selected)
        nav3.tabBarItem.image = UIImage(named: "tabbar_discover")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        nav3.tabBarItem.selectedImage = UIImage(named: "tabbar_discover_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        //.创建个人中心导航控制器
        let fourthVC = FourthViewController();
        let nav4 = UINavigationController(rootViewController: fourthVC);
        nav4.title = "个人中心";
        nav4.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Selected)
        nav4.tabBarItem.image = UIImage(named: "tabbar_profile")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        nav4.tabBarItem.selectedImage = UIImage(named: "tabbar_profile_selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        //.添加到工具栏
        let items = [nav1,nav2,nav3,nav4];
        self.viewControllers = items;
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor();
        //.自定义工具栏
        self.tabBar.backgroundColor=UIColor.clearColor();
        //底部工具栏背景颜色
//        self.tabBar.barTintColor=UIColor.blueColor();
//        self.tabBar.backgroundImage = UIImage(named: "f_navtop")
        //.设置底部工具栏文字颜色（默认状态和选中状态）
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.grayColor(), forKey:NSForegroundColorAttributeName) as? [String : AnyObject], forState:UIControlState.Normal);
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.blueColor(), forKey:NSForegroundColorAttributeName) as? [String : AnyObject], forState:UIControlState.Selected)
        //self.tabBar.tintColorDidChange()=UIColor.greenColor();
        //    let viewBar=UIView(frame:CGRectMake(,,UIScreen.mainScreen().bounds.width, ));
        //    viewBar.backgroundColor=UIColor(patternImage:UIImage(named:"TabbarBg.png")!);
        //    self.tabBar.insertSubview(viewBar, atIndex:)
        //    self.tabBar.opaque=true
        //    self.tabBar.tintColor=UIColor.appMainColor();
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
