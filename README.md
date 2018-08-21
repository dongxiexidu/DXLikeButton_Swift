# DXLikeButton

![likeBtn](https://github.com/dongxiexidu/DXLikeButton_Swift/blob/master/likeBtn.gif)

# 原理
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
参考了:[Objective-C版本](https://github.com/ImKcat/CatZanButton)
