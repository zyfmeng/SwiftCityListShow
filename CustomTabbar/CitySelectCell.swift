//
//  CitySelectCell.swift
//  CustomTabbar
//
//  Created by md on 16/7/26.
//  Copyright © 2016年 HKQ. All rights reserved.
//

import UIKit

class CitySelectCell: UITableViewCell {

    let indentify = "cityCell"
    var titleLab: UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: indentify)
        titleLab = UILabel()
        titleLab?.frame = CGRectMake(15, 0, 300, 40)
        titleLab?.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(titleLab!)
    }
    //展示城市名
    func contentCitySelect(info:CitySelectInfo){
        titleLab?.text = info.city_name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
