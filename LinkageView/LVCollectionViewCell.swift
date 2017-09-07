//
//  LVCollectionViewCell.swift
//  LinkageView
//
//  Created by 庆庆 on 2017/9/4.
//  Copyright © 2017年 qingqing. All rights reserved.
//

import UIKit

class LVCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            if let title = title {
                titleLbl.text = title
            }
        }
    }
    
    var titleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLbl = UILabel()
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
