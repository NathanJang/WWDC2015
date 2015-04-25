//
//  IntroViewController.swift
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-14.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    var helloLabel = {() -> UILabel in
        var helloLabel = UILabel()
        helloLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 86)
        helloLabel.text = "Hello"
        helloLabel.sizeToFit()
        return helloLabel
    }()
    var subtitleLabel = {() -> UILabel in
        var subtitleLabel = UILabel()
        subtitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        var attributedText = NSMutableAttributedString(string: "Jonathan Chan\nWWDC15")
        attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 24)!, range: NSRange(location: 14, length: 4))
        subtitleLabel.attributedText = attributedText
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subtitleLabel.sizeToFit()
        subtitleLabel.textAlignment = NSTextAlignment.Center
        subtitleLabel.alpha = 0
        return subtitleLabel
    }()
    var continueButton = {() -> UIButton in
        var continueButton = UIButton()
        continueButton.setBackgroundImage(UIImage(named: "RightArrowButton"), forState: UIControlState.Normal)
        continueButton.sizeToFit()
        continueButton.alpha = 0
        return continueButton
    }()
    var skipButton = {() -> UIButton in
        var skipButton = UIButton()
        skipButton.setBackgroundImage(UIImage(named: "RightSkipButton"), forState: UIControlState.Normal)
        skipButton.sizeToFit()
        skipButton.alpha = 0
        return skipButton
    }()
    var headphonesImageView = {() -> UIImageView in
        var headphonesImageView = UIImageView(image: UIImage(named: "HeadphonesIcon"))
        headphonesImageView.alpha = 0
        return headphonesImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.helloLabel.center = self.view.center
        self.subtitleLabel.center = self.view.center
        self.continueButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
        self.skipButton.center = CGPoint(x: self.view.center.x + self.skipButton.frame.width / 2, y: self.view.center.y + 100)
        self.headphonesImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 85)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.view.addSubview(self.helloLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.continueButton)
        self.continueButton.addTarget(self, action: "continueButtonTouchUpFirst", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.skipButton)
        self.skipButton.addTarget(self, action: "skipButtonTouchUp", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.headphonesImageView)

        UIView.animateWithDuration(1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.helloLabel.center.y -= 85
            self.subtitleLabel.alpha = 1
            self.continueButton.alpha = 1
        }, completion: nil)
    }

    func continueButtonTouchUpFirst() {
        self.continueButton.removeTarget(self, action: "continueButtonTouchUpFirst", forControlEvents: UIControlEvents.TouchUpInside)
        self.continueButton.addTarget(self, action: "continueButtonTouchUpSecond", forControlEvents: UIControlEvents.TouchUpInside)

        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.helloLabel.alpha = 0
            self.subtitleLabel.alpha = 0
            self.continueButton.center.x += -self.continueButton.frame.width / 2
            self.skipButton.alpha = 1
            self.headphonesImageView.alpha = 1
        }, completion: nil)
    }

    func continueButtonTouchUpSecond() {
        self.performSegueWithIdentifier("showAnimationView", sender: self)
    }

    func skipButtonTouchUp() {
        self.performSegueWithIdentifier("exitIntroView", sender: self)
    }
}
