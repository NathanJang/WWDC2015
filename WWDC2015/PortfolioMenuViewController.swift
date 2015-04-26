//
//  PortfolioMenuViewController.swift
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-15.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class PortfolioMenuViewController: UIViewController {

    var srtSignupButton = {() -> UIButton in
        var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle("SRT-signup", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Menlo-Regular", size: 42)
        button.sizeToFit()

        var imageView = UIImageView(image: UIImage(named: "RightArrowIconLight"))
        imageView.frame.origin.x = button.frame.width
        imageView.center.y = button.frame.height / 2
        button.addSubview(imageView)

        return button
    }()

    var qbButton = {() -> UIButton in
        var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle("quiz-buzzer", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Menlo-Regular", size: 38)
        button.sizeToFit()

        var imageView = UIImageView(image: UIImage(named: "RightArrowIconLight"))
        imageView.frame.origin.x = button.frame.width
        imageView.center.y = button.frame.height / 2
        button.addSubview(imageView)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.srtSignupButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.srtSignupButton.frame.height / 2)
        self.srtSignupButton.addTarget(self, action: "showSrtAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.srtSignupButton)

        self.qbButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.qbButton.frame.height / 2)
        self.qbButton.addTarget(self, action: "showQbAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.qbButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Alerts

    func showSrtAlert() {
        var alertController = UIAlertController(title: "SRT-signup", message: "SRT-signup is an online curriculum manager written with Ember.js and compiled with Grunt, and runs on a backend written in PHP. Work in progress.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Demo", style: UIAlertActionStyle.Default, handler: {(action) in
            UIApplication.sharedApplication().openURL(NSURL(string: "https://nathanjang.github.io/SRT-signup-demo/")!)
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func showQbAlert() {
        var alertController = UIAlertController(title: "quiz-buzzer", message: "quiz-buzzer is a wireless buzzer system for quiz games, based on Multipeer Connectivity. It is currently work in progress; please check out the current source code in this app's project.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
