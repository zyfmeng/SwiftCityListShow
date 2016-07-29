//
//  CitySelectViewController.swift
//  CustomTabbar
//
//  Created by md on 16/7/26.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit
import Alamofire

typealias CityNameBlock = (str:String,idStr:String) -> Void//声明一个block

//路径
var docs = [NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)]
let kDocumentPath = docs[0]

class CitySelectViewController: BaseADViewController,UITableViewDelegate,UITableViewDataSource {
    var cityNameBlock: CityNameBlock?//声明一个block变量

    var mTableView: UITableView?
    var totalArr: NSMutableArray?
    var metterDict: NSMutableDictionary?
    var saveArr: NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "城市列表"
        
        saveArr = NSMutableArray()
        totalArr = NSMutableArray()
        metterDict = NSMutableDictionary()
        
        mTableView = UITableView()
        mTableView?.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)
        mTableView?.delegate = self
        mTableView?.dataSource = self
        mTableView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mTableView!)
        
        //获取本地数据
        self.loadFromLocal()
        if self.totalArr?.count > 0 {
            self.getAllCityMetter()
            mTableView?.reloadData()
        }else{
            self.requestFromServer()
        }
        
    }
    //首字母相同的放在一起
    func getAllCityMetter(){
        for cityInfo in self.totalArr! {
            let info = cityInfo as! CitySelectInfo
            let s = metterDict![info.m_letter]
            if s == nil {
                var letterArr: NSMutableArray
                letterArr = NSMutableArray()
                    metterDict?.setObject(letterArr, forKey: info.m_letter)
                letterArr.addObject(info)
            }else{
                let m_letterArr = metterDict![info.m_letter] as! NSMutableArray
                m_letterArr.addObject(info)
            }
        }
    }
    //获得所有的key值并排序，并返回排好序的数组
    func getAllCityKey()->NSArray{
        let keys = metterDict!.allKeys as NSArray
        return keys.sortedArrayUsingSelector(#selector(NSNumber.compare(_:)))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = self.getAllCityKey() 
        return keys.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = self.getAllCityKey()
        let keyStr = keys[section]
        let values = metterDict?.objectForKey(keyStr)
        return (values?.count)!
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    //索引代理
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        let keys = self.getAllCityKey() as! [String]
        return keys
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = self.getAllCityKey() as! [String]
        //判断keys是否为空
        if keys.count > 0 {
            return keys[section]
        }else{
            return nil
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cityCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identify) as? CitySelectCell
        if cell == nil {
            cell = CitySelectCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier: identify)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let keys = self.getAllCityKey()//所有的key值
        let keyStr = keys[indexPath.section]//选择的是哪一组
        let values = metterDict?.objectForKey(keyStr)//获取该组下面的所有行
        let info = values![indexPath.row] as! CitySelectInfo//获取选中的行
        cell?.contentCitySelect(info)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let keys = self.getAllCityKey()
        let keyStr = keys[indexPath.section]
        let values = metterDict?.objectForKey(keyStr)
        let info = values?[indexPath.row] as! CitySelectInfo
        cityNameBlock!(str: info.city_name,idStr: String(info.city_id))//block传值（城市名）
        //保存到本地
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(info.city_name, forKey: "CITY_NAME")
        defaults.synchronize()
        
        let defaults2 = NSUserDefaults.standardUserDefaults()
        let city_idStr = String(info.city_id)
        defaults.setValue(city_idStr, forKey: "CITY_ID")
        defaults2.synchronize()
        print(city_idStr)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //网络请求
    func requestFromServer(){
        let urlStr = "http://apis.baidu.com/baidunuomi/openapi/cities"
        let headDict = ["apikey": "2304cdaee07aa52690475edf3776cce6"]
        self.startLoading()
        Alamofire.request(.GET, urlStr, parameters: nil, encoding: .URL, headers: headDict).responseJSON {response in
            if let JsonValue = response.result.value{
                self.stopLoading()
//                print(JsonValue)
                if (JsonValue.objectForKey("msg") as? String) == "success"{
                    let cities = JsonValue.objectForKey("cities") as! NSArray
                    self.saveArr = NSMutableArray(array: cities)
                    if cities.count > 0{
                        for dict in cities{
                            let netDic = dict as! NSDictionary
                            let cityid = netDic["city_id"] as! NSNumber
                            let cityname = netDic["city_name"] as! String
                            let citypinyin = netDic["city_pinyin"] as! String
                            let shortname = netDic["short_name"] as! String
                            let shortpinyin = netDic["short_pinyin"] as! String
                            //首字母大写
                            let s = netDic["city_pinyin"] as! String
                            let index = s.startIndex.advancedBy(1)
                            let letterStr = s.substringToIndex(index).uppercaseString
                            let m_letter = letterStr
                            
                            let info = CitySelectInfo(city_id: cityid, city_name: cityname, city_pinyin: citypinyin, short_name: shortname, short_pinyin: shortpinyin,m_letter: m_letter)
                            self.totalArr?.addObject(info)
                        }
                    }
                }
                
            }
            //保存到本地
            if self.totalArr?.count > 0{
                self.saveToLocal()
            }
            //首字母升序排列
            self.getAllCityMetter()
            
            self.mTableView?.reloadData()
        }
    }
    //保存到本地
    func saveToLocal(){
        //获取沙盒的根路径
        let home = NSHomeDirectory() as NSString
        //获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docpath = home.stringByAppendingPathComponent("Library/Caches") as NSString
        //获取文本文件路径
        let filePath = docpath.stringByAppendingPathComponent("cityList.plist")
        //将数据写入文件中
        saveArr?.writeToFile(filePath, atomically: true)
    }
    //获取本地数据
    func loadFromLocal(){
        totalArr?.removeAllObjects()
        saveArr?.removeAllObjects()
        //获取沙盒的根路径
        let home = NSHomeDirectory() as NSString
        //获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docpath = home.stringByAppendingPathComponent("Library/Caches") as NSString
        //获取文本文件路径
        let filePath = docpath.stringByAppendingPathComponent("cityList.plist")
        let array = NSArray(contentsOfFile:filePath)
        if array != nil {
//            print("kkkkkkk = \(array! as NSArray)")
            if array!.count > 0 {
                for dictionary in array! {
                    saveArr?.addObject(dictionary)
                }
                for item in saveArr! {
                    let netDic = item as! NSDictionary
                    let cityid = netDic["city_id"] as! NSNumber
                    let cityname = netDic["city_name"] as! String
                    let citypinyin = netDic["city_pinyin"] as! String
                    let shortname = netDic["short_name"] as! String
                    let shortpinyin = netDic["short_pinyin"] as! String
                    //首字母大写
                    let s = netDic["city_pinyin"] as! String
                    let index = s.startIndex.advancedBy(1)
                    let letterStr = s.substringToIndex(index).uppercaseString
                    let m_letter = letterStr
                    
                    let info = CitySelectInfo(city_id: cityid, city_name: cityname, city_pinyin: citypinyin, short_name: shortname, short_pinyin: shortpinyin,m_letter: m_letter)
                    self.totalArr?.addObject(info)
                }
            }else{
                return
            }

        }
        

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
