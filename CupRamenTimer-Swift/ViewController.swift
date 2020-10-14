//
//  ViewController.swift
//  CupRamenTimer-Swift
//
//  Created by i-5 on 6/5/16.
//  Copyright © 2016 JIO. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var endTime = NSDate()
    var timer = NSTimer()
    var cupRamenImageView = UIImageView()
    var timeLabel = UILabel()
    var startTime = NSDate.timeIntervalSinceReferenceDate()
    let duration = 180.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadImage()
        loadTimer()
        imageFadeIn()
    }
    
    func loadImage() {
    
        self.cupRamenImageView.frame = CGRect(x:0, y:0, width:350, height:370)
        let cupRamenImage = UIImage(named: "cup_noodle_op.jpg")
        self.cupRamenImageView.image = cupRamenImage
    }
    
    func loadTimer() {
        
        //let minute = duration / 3600
        
        self.timeLabel.text = "03:00"
        self.timeLabel.frame = CGRectMake(0, 0, 738, 400)
        self.timeLabel.font = UIFont(name: "Arial", size: 74.0)
        //self.timeLabel.sizeToFit()
        self.timeLabel.center = CGPointMake(384, 512);
        self.view.addSubview(self.timeLabel)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func updateTime(timer: NSTimer) {
        
        let now = NSDate()
        let remainSecond = endTime.timeIntervalSinceDate(now)
        let timeLeft = max(remainSecond, 0)
        let minLeft = timeLeft / 60
        let secLeft = timeLeft % 60
        
        self.timeLabel.text = String(format:"%02d:%02d", minLeft, secLeft)
        
        if timeLeft < 1.0 {
            timer.invalidate()
            self.cupRamenImageView.removeFromSuperview()
            loadAnimation()
            loadReminderSound();
        }
        
    }
    
    func loadReminderSound() {
        
    }
    
    func loadAnimation() {
        
        var images: [UIImage] = []
        images.append(UIImage(named: "cup_noodle_op.jpg")!)
        
        for num in 1...4 {
            images.append(UIImage(named: "cup_noodle_op\(num).jpg")!)
        }
        
        self.cupRamenImageView.animationImages = images
        self.cupRamenImageView.animationDuration = 3.0
        self.cupRamenImageView.frame = CGRect(x:0, y:0, width:350, height:370)
        self.cupRamenImageView.startAnimating()
        self.view.addSubview(self.cupRamenImageView)
        
    }
    
    func imageFadeIn() {
        
        let secondImageView = self.cupRamenImageView
        secondImageView.frame = CGRect(x:0, y:0, width:350, height:370)
        secondImageView.alpha = 0.0
        view.insertSubview(secondImageView, aboveSubview: self.cupRamenImageView)
        
        UIView.animateWithDuration(3.0, delay: 2.0, options: .CurveEaseOut, animations: {
            secondImageView.alpha = 1.0
            }, completion: {_ in
                self.cupRamenImageView.image = secondImageView.image
        })
        
    }

}

