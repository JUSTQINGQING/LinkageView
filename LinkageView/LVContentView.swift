//
//  LVContentView.swift
//  LinkageView
//
//  Created by 庆庆 on 2017/8/29.
//  Copyright © 2017年 qingqing. All rights reserved.
//

import UIKit

protocol LVcontentDelegate: NSObjectProtocol {
    func contentView(_ contentView: LVContentView,nowPage: Int, fromIndex: Int, toIndex: Int, scale:CGFloat)
}

class LVContentView: UICollectionView {
    
    var currentX: CGFloat = 0.0
    var currentIndex: Int = 0
    var toIndex: Int = 0
    var dataArr: [String] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    weak var contentDelegate: LVcontentDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        register(LVCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        backgroundColor = UIColor.white
        bounces = false
        delegate = self
        dataSource = self
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LVContentView: UICollectionViewDelegate {
    
}

extension LVContentView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LVCollectionViewCell
        cell.title = dataArr[indexPath.item]
        return cell
    }
}

extension LVContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension LVContentView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //进行四舍五入取整再次计算成屏宽整数倍 是为了防止快速滑动过程出现怪异的滑动起点 导致scale 突变 使得滑动条闪动
        currentX = CGFloat(lroundf(Float(scrollView.contentOffset.x/LVWidth)))*LVWidth
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        let moveX = x - currentX

        let scale = abs(moveX.truncatingRemainder(dividingBy: LVWidth) / LVWidth)
        if scale == 0 { return } //如果不写这句 会导致在首末 快速多次滑动时 滚动条出现问题
        let page = Int(floor((x - LVWidth / 2) / LVWidth)) + 1
        if moveX > 0 {
             currentIndex = Int(x / LVWidth)
            toIndex = currentIndex + 1
        }else if moveX < 0 {
             currentIndex = Int(ceil(x / LVWidth))
            toIndex = currentIndex - 1
        }
        if toIndex < 0 {
            toIndex = 0
        }else if toIndex > dataArr.count-1 {
            toIndex = dataArr.count - 1
        }
        // page 标题颜色改变的index 只要触碰到边界就改变 scale 滑动条进度控制比
        // fromIndex 当前的index 完全切换页面才改变 toIndex 要切换到的index
        contentDelegate?.contentView(self,nowPage: page, fromIndex: currentIndex, toIndex: toIndex, scale: scale)
    }

}
