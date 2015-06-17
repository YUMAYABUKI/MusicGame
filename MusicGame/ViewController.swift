//
//  ViewController.swift
//  MusicGame
//
//  Created by 矢吹祐真 on 2015/06/17.
//  Copyright (c) 2015年 矢吹祐真. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var timelabel:UILabel!
    @IBOutlet var hanteiLabel:UILabel!
    
    var audio:AVPlayer!
    
    var count: Float = 0.0
    var timer: NSTimer = NSTimer()
    
    var spped: Float = 0.0
    var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if !timer.valid{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("up"), userInfo: nil, repeats: true)
        }
        label = UILabel(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        label.text = ""
        label.font = UIFont.systemFontOfSize(50)
        label.backgroundColor = UIColor.clearColor()
        self.view.addSubview(label)
        
        var appframe: CGRect = UIScreen.mainScreen().applicationFrame
        spped = Float(appframe.size.height) / 1.2
        
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Go", ofType:"mp3")!)
        audio = AVPlayer(URL: audioPath)
        audio.play()
    }
    
    func up(){
        count = count+0.01
        timelabel.text = String(format:"%.2f",count)
        
        if 10.0 - 1.2 <= count{
            label.text = "◼︎"
            var y:Float = (count - 10.0 + 1.2) * spped - 75
            label.frame = CGRectMake(135, CGFloat(y), 50, 50)
        }
    }
    
    func hantei(number:Float) -> String{
        if count > number - 0.20 && count < number + 0.20{
            return"PERFECT!"
        }else if count > number - 0.30 && count < number + 0.30{
            return"GREAT!"
        }else if count > number - 0.50 && count < number + 0.50{
            return"GOOD!"
        }else {
            return"BAD!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushButton(){
        hanteiLabel.text = self.hantei(10.0)
        audio.pause()
    }
}

