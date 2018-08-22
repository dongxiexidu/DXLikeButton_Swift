//
//  ViewController.swift
//  DXLikeButtonDemo
//
//  Created by fashion on 2018/8/21.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteButton: DXFavoriteButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
//        let likeBtn = DXLikeButton.init(frame: frame)
//        likeBtn.type = .firework
//        likeBtn.center = view.center
//        view.addSubview(likeBtn)
//        
//        likeBtn.clickHandler = { btn in
//            print(btn.isLike)
//        }
        
        
        let width = (self.view.frame.width - 44) / 4
        var x = width / 2
        let y = self.view.frame.height / 2 - 22
        
        // star button
        let starButton = DXFavoriteButton.init(frame: CGRect(x: x, y: y, width: 44, height: 44), image: #imageLiteral(resourceName: "star"))
        starButton.addTarget(self, action: #selector(self.favoriteButtonClick), for: .touchUpInside)
        view.addSubview(starButton)
        x += width
        
        // heart button
        let heartButton = DXFavoriteButton(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "heart"))
        heartButton.favoredColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        heartButton.addTarget(self, action: #selector(self.favoriteButtonClick), for: .touchUpInside)
        view.addSubview(heartButton)
        x += width
        
        // like button
        let likeButton = DXFavoriteButton(frame: CGRect(x: x, y: y, width: 44, height: 44), image:#imageLiteral(resourceName: "like"))
        likeButton.favoredColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.circleColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.lineColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        likeButton.addTarget(self, action: #selector(self.favoriteButtonClick), for: .touchUpInside)
        view.addSubview(likeButton)
        x += width
        
        // smile button
        let smileButton = DXFavoriteButton(frame: CGRect(x: x, y: y, width: 44, height: 44), image: #imageLiteral(resourceName: "smile"))
        smileButton.favoredColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.circleColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.lineColor = UIColor(red: 45/255, green: 195/255, blue: 106/255, alpha: 1.0)
        smileButton.addTarget(self, action: #selector(self.favoriteButtonClick), for: .touchUpInside)
        view.addSubview(smileButton)

    }

    @IBAction func favoriteButtonClick(_ sender: DXFavoriteButton) {
        sender.isSelected = !sender.isSelected
    }
    


}

