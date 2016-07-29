//
//  CitySelectInfo.swift
//  CustomTabbar
//
//  Created by md on 16/7/26.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit
import Foundation

class CitySelectInfo: NSObject {

    var city_id: NSNumber//城市id
    var city_name: String//城市名
    var city_pinyin: String//城市拼音
    var short_name: String//缩写名称
    var short_pinyin: String//缩写拼音
    var m_letter: String//拼音首字母
    
    init(city_id:NSNumber,city_name:String,city_pinyin:String,short_name:String,short_pinyin:String,m_letter:String){
        self.city_id = city_id
        self.city_name = city_name
        self.city_pinyin = city_pinyin
        self.short_name = short_name
        self.short_pinyin = short_pinyin
        self.m_letter = m_letter
        super.init()
    }
}
