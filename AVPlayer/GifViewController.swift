//
//  GifViewController.swift
//  AVPlayer
//
//  Created by lsq on 2017/11/7.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class GifViewController: UIViewController {
    deinit {
        print("GifViewController->释放")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "gif"
        
        self.loadGif()
    }

    fileprivate let gifName1 = "rightgif.gif"
    fileprivate let gifName2 = "wronggif.gif"
    
    fileprivate func loadGif(){
        
        var images = [String]()
        for i in 0..<3{
            let imageName = "chat_\(i)"
            images.append(imageName)
        }
        let rect0 = CGRect(x: 100, y: 80, width: 32, height: 32)
        let gifView0 = LsqGifView(frame: rect0, images: images)
        gifView0.backgroundColor = UIColor.groupTableViewBackground
        gifView0.imageTouchHandle = { [weak self](imageView) in
            if imageView.isAnimating {
                imageView.stopAnimating()
                imageView.image = UIImage(named: "chat_2")
                self?.view.backgroundColor = UIColor.yellow
            }else{
                imageView.startAnimating()
                imageView.image = UIImage(named: "chat_2")
                self?.view.backgroundColor = UIColor.white
            }
        }
        self.view.addSubview(gifView0)
        
        let x = (self.view.frame.width - 150) / 2
        let rect = CGRect(x: x, y: 150, width: 150, height: 150)
        
        let gifView = LsqGifView(frame: rect, gifName: gifName1)
        gifView.center = self.view.center
        
        gifView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(gifView)
        
        let rect2 = CGRect(x: x, y: 450, width: 150, height: 96)
        let gifView2 = LsqGifView(frame: rect2
            , gifName: gifName2)
        gifView2.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(gifView2)
        
        
        
    }

}
