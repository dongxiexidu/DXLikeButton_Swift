//
//  ViewController.swift
//  DXLikeButtonDemo
//
//  Created by fashion on 2018/8/21.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
       // let likeBtn = DXLikeButton.init(frame: frame, zanImage: nil, unZanImage: nil)
        let likeBtn = DXLikeButton.init(frame: frame)
        likeBtn.type = .firework
        likeBtn.center = view.center
        view.addSubview(likeBtn)
        
        likeBtn.clickHandler = { btn in
            print(btn.isLike)
        }
    }




}

