//
//  ViewController.swift
//  AVPlayer
//
//  Created by lsq on 2017/10/11.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var playerBtn: UIButton!

    @IBOutlet weak var stopBtn: UIButton!
    
    let syntesizer = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.syntesizer.delegate = self
    }


    @IBAction func playerAct(_ sender: UIButton) {
        
 
        let isStop = syntesizer.isPaused
        print("是否暂停了：\(isStop)")
        let isPlay = syntesizer.isSpeaking
        print("是否在播放:\(isPlay)")
        
        if !isStop{
            if !isPlay{
                let text = "从前有座山，山里有座庙。庙里有个老和尚呢。"
                
                utterance = AVSpeechUtterance(string: text)
                
                utterance.rate = 0.5
                
                syntesizer.speak(utterance)
            }else{
                syntesizer.pauseSpeaking(at: .immediate)
            }
            
        }else{//暂停中
            syntesizer.continueSpeaking()
        }
        
    }
    @IBAction func stopAct(_ sender: UIButton) {
        
        let isStop = syntesizer.isPaused
        print("-stop-是否暂停了：\(isStop)")
        let isPlay = syntesizer.isSpeaking
        print("-stop-是否在播放:\(isPlay)")
        
        if isPlay && !isStop{
            syntesizer.pauseSpeaking(at: .immediate)
            
        }

   
    }

    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("开始播放")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("播放完成")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("暂停播放")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("继续播放")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("停止播放")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
//        print("播放过程中")
    }
    
    
    
    @IBAction func gitAct(_ sender: Any) {
        
        let gifVC = GifViewController()
        
        self.navigationController?.pushViewController(gifVC, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
}



