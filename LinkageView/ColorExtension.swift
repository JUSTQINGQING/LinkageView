//
//  ColorExtension.swift
//  LinkageView
//
//  Created by 庆庆 on 2017/9/1.
//  Copyright © 2017年 qingqing. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(colors: [CGFloat]) {
        self.init(red: colors[0]/255.0, green: colors[1]/255.0, blue: colors[2]/255.0, alpha: 1)
    }
}
