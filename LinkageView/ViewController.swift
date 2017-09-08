//
//  ViewController.swift
//  LinkageView
//
//  Created by 庆庆 on 2017/9/7.
//  Copyright © 2017年 qingqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var headerView: LVHeaderView!
    fileprivate var contentView: LVContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .blackTranslucent;
        navigationController?.navigationBar.barTintColor = getColor(selectedColor)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        
        let arr = ["个性推荐", "歌单", "主播平台", "排行榜", "个性推荐", "歌单", "主播平台", "排行榜"]
        
        headerView = LVHeaderView.init(styleMore: true, styleLine: false)
        view.addSubview(headerView)
        headerView.delegate = self
        headerView.dataAry = arr
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contentView = LVContentView()
        view.addSubview(contentView)
        self.contentView.dataArr = arr
        contentView.contentDelegate = self
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.right.left.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension ViewController: LVHeaderViewDelegate {
    func selectdLVHeaderView(view: LVHeaderView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        contentView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

extension ViewController: LVcontentDelegate {
    func contentView(_ contentView: LVContentView,nowPage: Int, fromIndex: Int, toIndex: Int, scale: CGFloat) {
        headerView.scrollTodo(nowPage: nowPage, fromIndex: fromIndex, toIndex: toIndex, scale: scale)
    }
}

