# DXLikeButton & DXFavoriteButton

![likeBtn](https://github.com/dongxiexidu/DXLikeButton_Swift/blob/master/likeBtn.gif)
![favoriteButton](https://github.com/dongxiexidu/DXLikeButton_Swift/blob/master/favoriteButton.gif)

# DXLikeButton原理
- 1.自定义`DXLikeButton`继承`UIControl`
- 2.自定义`UIImageView`,添加到`DXLikeButton`
- 3.在`UIImageView`上添加点击事件,处理动画效果
- 4.粒子发射动画由`CAEmitterLayer`和`CAEmitterCell`联合实现


# Example
```
let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
let likeBtn = DXLikeButton.init(frame: frame)
likeBtn.type = .firework
likeBtn.center = view.center
view.addSubview(likeBtn)
```

[Objective-C 版本](https://github.com/ImKcat/CatZanButton)

# DXFavoriteButton

## Feature
- [x] 支持Xib,纯代码
- [x] 动画执行期间,禁止点击
- [x] `Button`添加`touchDown`效果

## Customize
```
likeButton.defaultColor = .brown
likeButton.favoredColor = .brown
likeButton.circleColor = .brown
likeButton.lineColor = .brown
likeButton.duration = 2.0 // default: 1.0
```
# Usage
```
// star button
let starButton = DXFavoriteButton.init(frame: CGRect(x: x, y: y, width: 44, height: 44), image: #imageLiteral(resourceName: "star"))
starButton.addTarget(self, action: #selector(self.favoriteButtonClick), for: .touchUpInside)
view.addSubview(starButton)

@IBAction func favoriteButtonClick(_ sender: DXFavoriteButton) {
    sender.isSelected = !sender.isSelected
}
```

参考:
[DOFavoriteButton](https://github.com/okmr-d/DOFavoriteButton)
[Objective-C 版本](https://github.com/Sunnyyoung/SYFavoriteButton)

