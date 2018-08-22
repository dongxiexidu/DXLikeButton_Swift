//
//  DXFavoriteButton.swift
//  DXLikeButtonDemo
//
//  Created by fashion on 2018/8/21.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

@IBDesignable
open class DXFavoriteButton: UIButton {

    @IBInspectable
    public var image : UIImage!{
        didSet(newValue){
            createLayers(image: image)
        }
    }
    
    @IBInspectable
    public var favoredColor : UIColor = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0){
        didSet(newValue){
            if isSelected {
                imageShape.fillColor = newValue.cgColor
            }
        }
    }
    
    @IBInspectable
    public var defaultColor : UIColor! = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0){
        didSet(newValue){
            if !isSelected {
                imageShape.fillColor = newValue.cgColor
            }
        }
    }
    
    @IBInspectable
    public var circleColor : UIColor = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0){
        didSet(newValue){
            circleShape.fillColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    public var lineColor : UIColor = UIColor(red: 250/255, green: 120/255, blue: 68/255, alpha: 1.0){
        didSet(newValue){
            for line in lines {
                line.strokeColor = newValue.cgColor
            }
        }
    }
    
    @IBInspectable
    public var duration : Double = 1.0 {
        didSet(newValue){
            circleTransform.duration     = CFTimeInterval(0.333 * newValue)
            circleMaskTransform.duration = CFTimeInterval(0.333 * newValue)
            lineStrokeStart.duration     = CFTimeInterval(0.6 * newValue)
            lineStrokeEnd.duration       = CFTimeInterval(0.6 * newValue)
            lineOpacity.duration         = CFTimeInterval(1.0 * newValue)
            imageTransform.duration      = CFTimeInterval(1.0 * newValue)
        }
    }
    
    private var imageShape: CAShapeLayer!
    private var circleShape: CAShapeLayer!
    private var circleMask: CAShapeLayer!
    
    private var lines : [CAShapeLayer]!
    
    private var circleTransform = CAKeyframeAnimation.init(keyPath: "transform")
    private var circleMaskTransform = CAKeyframeAnimation.init(keyPath: "transform")
    private var lineStrokeStart = CAKeyframeAnimation.init(keyPath: "strokeStart")
    private var lineStrokeEnd = CAKeyframeAnimation.init(keyPath: "strokeEnd")
    private var lineOpacity = CAKeyframeAnimation.init(keyPath: "opacity")
    private var imageTransform = CAKeyframeAnimation.init(keyPath: "transform")
    
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect,image: UIImage!) {
        self.init(frame: frame)
        
        self.image = image
        createLayers(image: image)
        addTargets()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayers(image: UIImage())
        addTargets()
    }
    
    override open var isSelected: Bool {
        didSet(newValue){
            if newValue == false {
                imageShape.fillColor = favoredColor.cgColor
                select()
            }else{
                deselect()
            }
        }
    }
    
    private func select() {
        imageShape.fillColor = favoredColor.cgColor
        // 动画执行期间,禁止点击
        isUserInteractionEnabled = false
        CATransaction.setCompletionBlock {
            self.isUserInteractionEnabled = true
        }
        CATransaction.begin()
        circleShape.add(circleTransform, forKey: "transform")
        circleMask.add(circleMaskTransform, forKey: "transform")
        imageShape.add(imageTransform, forKey: "transform")
        
        for i in 0 ..< 5 {
            lines[i].add(lineStrokeStart, forKey: "strokeStart")
            lines[i].add(lineStrokeEnd, forKey: "strokeEnd")
            lines[i].add(lineOpacity, forKey: "opacity")
        }
        CATransaction.commit()
        
    }
    private func deselect() {
        
        imageShape.fillColor = defaultColor.cgColor
        
        circleShape.removeAllAnimations()
        circleMask.removeAllAnimations()
        imageShape.removeAllAnimations()
        for line in lines {
            line.removeAllAnimations()
        }
    }
    
    func addTargets() {
        addTarget(self, action: #selector(touchDown(button:)), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside(button:)), for: .touchUpInside)
        addTarget(self, action: #selector(touchDragExit(button:)), for: .touchDragExit)
        addTarget(self, action: #selector(touchDragEnter(button:)), for: .touchDragEnter)
        addTarget(self, action: #selector(touchCancel(button:)), for: .touchCancel)
    }
    
    @objc func touchDown(button: UIButton) {
        layer.opacity = 0.4
    }
    @objc func touchUpInside(button: UIButton) {
        layer.opacity = 1.0
    }
    @objc func touchDragExit(button: UIButton) {
        layer.opacity = 1.0
    }
    @objc func touchDragEnter(button: UIButton) {
        layer.opacity = 0.4
    }
    @objc func touchCancel(button: UIButton) {
        layer.opacity = 1.0
    }
    
    private func createLayers(image: UIImage) {
        layer.sublayers = nil
        let imageFrame = CGRect.init(x: frame.size.width/2-frame.size.width/4,
                                     y: frame.size.height/2-frame.size.height/4,
                                     width: frame.size.width/2,
                                     height: frame.size.height/2)
        
        let imgCenterPoint = CGPoint.init(x: imageFrame.midX, y: imageFrame.midY)
        let lineFrame = CGRect.init(x: imageFrame.origin.x-imageFrame.size.width/4,
                                    y: imageFrame.origin.y-imageFrame.size.height/4,
                                    width:imageFrame.size.width*1.5,
                                    height: imageFrame.size.height*1.5)
     
        //=============
        // circle layer
        //=============
        circleShape = CAShapeLayer()
        circleShape.bounds = imageFrame
        circleShape.position = imgCenterPoint
        circleShape.path = UIBezierPath.init(ovalIn: imageFrame).cgPath
        circleShape.fillColor = circleColor.cgColor
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        layer.addSublayer(circleShape)
        
        circleMask = CAShapeLayer()
        circleMask.bounds = imageFrame;
        circleMask.position = imgCenterPoint
        circleMask.fillRule = kCAFillRuleEvenOdd
        circleShape.mask = circleMask
        
        let maskPath = UIBezierPath.init(rect: imageFrame)
        maskPath.addArc(withCenter: imgCenterPoint, radius: 0.1, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        circleMask.path = maskPath.cgPath
        
        //===============
        // line layer
        //===============
        lines = [CAShapeLayer]()
        for i in 0..<5 {
            let line = CAShapeLayer.init()
            line.bounds = lineFrame
            line.position = imgCenterPoint
            line.masksToBounds = true
            
            line.actions = ["strokeStart":NSNull() ,"strokeEnd":NSNull()]
            line.lineWidth = 1.25
            line.miterLimit = 1.25
            
            line.path = {
                let path = CGMutablePath.init()
                path.move(to: CGPoint.init(x: lineFrame.midX, y: lineFrame.midY))
                path.addLine(to: CGPoint.init(x: lineFrame.origin.x+lineFrame.size.width/2, y: lineFrame.origin.y))
                return path
            }()

            line.lineCap = kCALineCapRound
            line.lineJoin = kCALineJoinRound
            line.strokeStart = 0
            line.strokeEnd = 0
            line.opacity = 0
            
            line.transform = CATransform3DMakeRotation(CGFloat.pi/CGFloat(5)*(CGFloat(i*2+1)), 0, 0, 1.0)
            layer.addSublayer(line)
            lines.append(line)
        }
        
        //===============
        // image layer
        //===============
        imageShape = CAShapeLayer()
        imageShape.bounds = imageFrame
        imageShape.position = imgCenterPoint
        imageShape.path = UIBezierPath.init(rect: imageFrame).cgPath
        imageShape.fillColor = defaultColor.cgColor
        imageShape.actions = ["fillColor" : NSNull()]
        layer.addSublayer(imageShape)
        
        imageShape.mask = CALayer()
        imageShape.mask?.contents = image.cgImage
        imageShape.mask?.bounds = imageFrame
        imageShape.mask?.position = imgCenterPoint
        
        //==============================
        // circle transform animation
        //==============================
        circleTransform.duration = 0.333
        circleTransform.values = [
            NSValue.init(caTransform3D: CATransform3DMakeScale(0, 0, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.5, 0.5, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1, 1, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.3, 1.3, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.37, 1.37, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.4, 1.4, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.4, 1.4, 1))
        ]
        
        circleTransform.keyTimes = [
            0.0,    //  0/10
            0.1,    //  1/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            1.0     // 10/10
        ]
//        circleTransform.keyTimes = [
//            NSNumber.init(value: 0),
//            NSNumber.init(value: 0.1),
//            NSNumber.init(value: 0.2),
//            NSNumber.init(value: 0.3),
//            NSNumber.init(value: 0.4),
//            NSNumber.init(value: 0.5),
//            NSNumber.init(value: 0.6),
//            NSNumber.init(value: 0.7)
//        ]
        
        circleMaskTransform.duration = 0.333
        circleMaskTransform.values = [
        NSValue.init(caTransform3D: CATransform3DIdentity),
        NSValue.init(caTransform3D: CATransform3DIdentity),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 1.25, imageFrame.size.height * 1.25, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 2.688, imageFrame.size.height * 2.688, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 3.923, imageFrame.size.height * 3.923, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 4.375, imageFrame.size.height * 4.375, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 4.731, imageFrame.size.height * 4.731, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 5.0, imageFrame.size.height * 5.0, 1)),
        NSValue.init(caTransform3D: CATransform3DMakeScale(imageFrame.size.width * 5.0, imageFrame.size.height * 5.0, 1))
        
        ]
        
        circleMaskTransform.keyTimes = [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.2),
            NSNumber.init(value: 0.3),
            NSNumber.init(value: 0.4),
            NSNumber.init(value: 0.5),
            NSNumber.init(value: 0.6),
            NSNumber.init(value: 0.7),
            NSNumber.init(value: 0.9),
            NSNumber.init(value: 1.0)
        ]
        //==============================
        // line stroke animation
        //==============================
        lineStrokeStart.duration = 0.6
        lineStrokeStart.values = [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.0),
            NSNumber.init(value: 0.18),
            NSNumber.init(value: 0.2),
            NSNumber.init(value: 0.26),
            NSNumber.init(value: 0.32),
            NSNumber.init(value: 0.4),
            NSNumber.init(value: 0.6),
            NSNumber.init(value: 0.71),
            NSNumber.init(value: 0.89),
            NSNumber.init(value: 0.92),
        ]
        lineStrokeStart.keyTimes = [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.056),
            NSNumber.init(value: 0.111),
            NSNumber.init(value: 0.167),
            NSNumber.init(value: 0.222),
            NSNumber.init(value: 0.278),
            NSNumber.init(value: 0.333),
            NSNumber.init(value: 0.389),
            NSNumber.init(value: 0.444),
            NSNumber.init(value: 0.944),
            NSNumber.init(value: 1.0),
        ]
        lineStrokeEnd.values = [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.0),
            NSNumber.init(value: 0.32),
            NSNumber.init(value: 0.48),
            NSNumber.init(value: 0.64),
            NSNumber.init(value: 0.68),
            NSNumber.init(value: 0.92),
            NSNumber.init(value: 0.92),
        ]
        
        lineStrokeEnd.duration = 0.6
        lineStrokeEnd.keyTimes = [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.056),
            NSNumber.init(value: 0.111),
            NSNumber.init(value: 0.167),
            NSNumber.init(value: 0.222),
            NSNumber.init(value: 0.278),
            NSNumber.init(value: 0.944),
            NSNumber.init(value: 1.0),
        ]
        
        lineOpacity.duration = 1.0 //0.0333 * 30
        lineOpacity.values = [
            NSNumber.init(value: 1.0),
            NSNumber.init(value: 1.0),
            NSNumber.init(value: 0)
        ]
        lineOpacity.keyTimes = [
            NSNumber.init(value: 0.0),
            NSNumber.init(value: 0.4),
            NSNumber.init(value: 0.567)
        ]
        
        //==============================
        // image transform animation
        //==============================
        imageTransform.duration = 1.0
        imageTransform.values = [
            NSValue.init(caTransform3D: CATransform3DMakeScale(0, 0, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0, 0, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.25, 1.25, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1)),
            
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.025, 1.025, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.96, 0.96, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.95, 0.95, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.96, 0.96, 1)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.99, 0.99, 1)),
            NSValue.init(caTransform3D: CATransform3DIdentity)
        ]
        imageTransform.keyTimes =  [
            NSNumber.init(value: 0),
            NSNumber.init(value: 0.1),
            NSNumber.init(value: 0.3),
            NSNumber.init(value: 0.333),
            NSNumber.init(value: 0.367),
            NSNumber.init(value: 0.467),
            NSNumber.init(value: 0.5),
            NSNumber.init(value: 0.567),
            NSNumber.init(value: 0.667),
            NSNumber.init(value: 0.7),
            NSNumber.init(value: 0.733),
            NSNumber.init(value: 0.833),
            NSNumber.init(value: 0.867),
            NSNumber.init(value: 0.9),
            NSNumber.init(value: 0.967),
            NSNumber.init(value: 1.0)
        ]
    }
}
