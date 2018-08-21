//
//  DXLikeButton.swift
//  DXLikeButtonDemo
//
//  Created by fashion on 2018/8/21.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

enum DXLikeButtonType {
    case firework
    case focus
}

class DXLikeButton: UIControl {

    ///  A bool value for button current status
    public var isLike : Bool = false {
        
        didSet (newValue){
            if newValue {
                likeImageView.image = dislikeImage
            }else{
                likeImageView.image = likeImage
            }
        }
    }
    
    /// A enum for button animation type
    public var type : DXLikeButtonType = .firework
    
    /// A handler for click button action
    public var clickHandler : ((DXLikeButton)->())?
    
    private var likeImageView : UIImageView = UIImageView()
    private var dislikeImage : UIImage!
    private var likeImage : UIImage!
    private var effectLayer : CAEmitterLayer = CAEmitterLayer()
    private var effectCell : CAEmitterCell = CAEmitterCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isLike = false
        dislikeImage = UIImage.init(named: "UnZan.png")
        likeImage = UIImage.init(named: "Zan.png")
        initBaseLayout()
    }
    
    convenience init(frame: CGRect,zanImage: UIImage?,unZanImage: UIImage?) {
        self.init(frame: frame)

        if let zanImg = zanImage {
            likeImage = zanImg
        }
        if let unZanImg = unZanImage {
            dislikeImage = unZanImg
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBaseLayout() {
        switch type {
        case .firework:
            effectLayer.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.layer.addSublayer(effectLayer)
            
            effectLayer.emitterShape = kCAEmitterLayerCircle
            effectLayer.emitterMode = kCAEmitterLayerOutline
            effectLayer.position = CGPoint.init(x: self.frame.width/2, y: self.frame.height/2)
            effectLayer.emitterSize = CGSize.init(width: self.frame.width, height: self.frame.height)
            
            effectCell.name = "zanShape"
            effectCell.contents = UIImage.init(named: "EffectImage")?.cgImage
            effectCell.alphaSpeed = -1
            effectCell.lifetime = 1
            effectCell.birthRate = 0
            effectCell.velocity = 50
            effectCell.velocityRange = 50
            effectLayer.emitterCells = [effectCell]
            
            likeImageView.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
            likeImageView.image = dislikeImage
            likeImageView.isUserInteractionEnabled = true
            self.addSubview(likeImageView)
            
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(likeAnimationPlay))
            likeImageView.addGestureRecognizer(singleTap)
            
        default:
            break
        }
    }
    
    @objc func likeAnimationPlay() {
       
        isLike = !isLike
        clickHandler?(self)
        
        switch type {
        case .firework:
            
            likeImageView.bounds = CGRect.zero
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .curveLinear, animations: {
                
                 self.likeImageView.bounds = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                
                if self.isLike {
                    let effectLayerAnimation = CABasicAnimation.init(keyPath: "emitterCells.zanShape.birthRate")
                    effectLayerAnimation.fromValue = NSNumber.init(value: 100)
                    effectLayerAnimation.toValue = NSNumber.init(value: 0)
                    effectLayerAnimation.duration = 0
                    effectLayerAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
                    self.effectLayer.add(effectLayerAnimation, forKey: "ZanCount")
                }
            }, completion: nil)

        default:
            break
        }

    }

}
