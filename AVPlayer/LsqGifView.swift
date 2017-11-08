//
//  LsqGifView.swift
//  AVPlayer
//
//  Created by lsq on 2017/11/7.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit
import ImageIO

enum ShowType {
    case imags
    case gif
}

class LsqGifView: UIView {
    deinit {
        print("LsqGifView->释放")
    }

    public var oneDuration: TimeInterval = 0.5
    public var imageTouchHandle: ((UIImageView)->Swift.Void)?
    
    
    fileprivate var gifName: String?
    fileprivate var imageView: UIImageView?
    

    
    convenience init(frame: CGRect, gifName: String) {
        self.init(frame: frame)
        self.gifName = gifName
        self.show(type: .gif)
    }
    fileprivate var images = [UIImage]()
    convenience init(frame: CGRect, images: [String]) {
        self.init(frame: frame)
        
        for image in images{
            if let img = UIImage(named: image){
                self.images.append(img)
            }
        }
        self.show(type: .imags)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.addSubview(imageView!)
        self.imageView?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageAct(_:)))
        self.imageView?.addGestureRecognizer(tap)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func imageAct(_ send: UITapGestureRecognizer){
        let imgView = send.view as! UIImageView
        
        self.imageTouchHandle?(imgView)
    }
    
    
    fileprivate func show(type: ShowType){
        
        switch type {
        case .gif:
            self.showGif()
        case .imags:
            self.showImages()
        }
        
    }
    
    
    fileprivate func showGif(){
        guard let gif = self.gifName else {return}
        guard let url = Bundle.main.url(forResource: gif, withExtension: nil) else {return}
        var tmpData: Data?
        do {
            tmpData = try Data(contentsOf: url)
        } catch {
            print(error)
        }
        guard let data = tmpData as CFData? else {return}
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else{return}
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        let imageCount = CGImageSourceGetCount(imageSource)
        for i in 0..<imageCount{
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {return}
            let image = UIImage(cgImage: cgImage)
            if i == 0{
                imageView?.image = image
            }else{
                imageView?.image = UIImage()
            }
            images.append(image)
            guard let properties = (CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? [String:Any]) else {return}
            guard let gifDic = (properties["\(kCGImagePropertyGIFDictionary)"] as? [String:Any]) else {return}
            guard let frameDuration = (gifDic["\(kCGImagePropertyGIFDelayTime)"] as? NSNumber) else {continue}
            totalDuration += frameDuration.doubleValue
        }
        self.imageView?.animationImages = images
        self.imageView?.animationDuration = totalDuration
        self.imageView?.animationRepeatCount = 0
        self.imageView?.startAnimating()
    }
    fileprivate func showImages(){
        self.imageView?.animationImages = self.images
        self.imageView?.animationDuration = self.oneDuration * TimeInterval(self.images.count)
        self.imageView?.animationRepeatCount = 0
        self.imageView?.startAnimating()
    }
}
