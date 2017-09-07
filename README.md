# LinkageView
联动视图，有网易云音乐效果及网易新闻效果

## Support

* 支持snpkit框架
* 支持修改各种颜色
* 支持自定义组件内容
* 支持两种菜单多屏及单屏
* 支持滑动条动态自适应标题长度
* 组头和内容分开编码，易于扩展，自己也会持续更新

## Usage

```swift
//默认效果：一屏菜单 可以省略参数
headerView = LVHeaderView.init(styleMore: false)
```
![一屏菜单.gif](http://upload-images.jianshu.io/upload_images/5075721-fa06b6ab1208eacd.gif?imageMogr2/auto-orient/strip)
------------------
```swift
//多屏菜单效果
headerView = LVHeaderView.init(styleMore: true)
```
![多屏菜单.gif](http://upload-images.jianshu.io/upload_images/5075721-08f3ace12d1f64af.gif?imageMogr2/auto-orient/strip)
------------------

具体使用
```swift
let arr = ["个性推荐", "歌单", "主播平台", "排行榜"]

headerView = LVHeaderView.init(styleMore: false)
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
```
代理方法
```swift
//头组件代理方法 实现标题点击的事件传递 使得内容组件响应滚动
extension ViewController: LVHeaderViewDelegate {
    func selectdLVHeaderView(view: LVHeaderView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        contentView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
//内容组件代理方法 实现与组头的联动效果
extension ViewController: LVcontentDelegate {
    func contentView(_ contentView: LVContentView,nowPage: Int, fromIndex: Int, toIndex: Int, scale: CGFloat) {
        headerView.scrollTodo(nowPage: nowPage, fromIndex: fromIndex, toIndex: toIndex, scale: scale)
    }
}
```

## Author

NickName：庆庆 

QiuQiu：674221479

Email: z.qing@my.com

有任何问题或者更好的建议 可以联系 谢谢

