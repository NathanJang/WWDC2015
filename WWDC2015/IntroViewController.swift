//
//  IntroViewController.swift
//  Jonathan Chan
//
//  Created by Jonathan Chan on 2015-04-14.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

let helveticaNeueUltraLightFontName = "HelveticaNeue-UltraLight"

import UIKit

class IntroViewController: UIViewController {
    var helloLabel = UILabel()
    var subtitleLabel = UILabel()
    var continueButton = UIButton(frame: CGRectMake(0, 0, 100, 100))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.helloLabel.font = UIFont(name: helveticaNeueUltraLightFontName, size: 72)
        self.helloLabel.text = "Hello."
        self.helloLabel.sizeToFit()
        self.helloLabel.center = self.view.center

        self.subtitleLabel.font = UIFont(name: helveticaNeueUltraLightFontName, size: 24)
        self.subtitleLabel.text = "Jonathan Chan\nWWDC 2015"
        self.subtitleLabel.numberOfLines = 2
        self.subtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.subtitleLabel.sizeToFit()
        self.subtitleLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 15)
        self.subtitleLabel.textAlignment = NSTextAlignment.Center
        self.subtitleLabel.alpha = 0

        self.continueButton.center = CGPointMake(self.view.center.x, self.view.center.y + 100)
        self.continueButton.setBackgroundImage(UIImage(named: "RightArrow"), forState: UIControlState.Normal)
        self.continueButton.alpha = 0
        self.continueButton.addTarget(self, action: "continueButtonTouchUp", forControlEvents: UIControlEvents.TouchUpInside)
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

        UIView.animateWithDuration(1, delay: 1.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.helloLabel.center.y += -75
            self.subtitleLabel.alpha = 1
            self.continueButton.alpha = 1
            self.continueButton.backgroundColor = UIColor.blueColor()
        }, completion: nil)
    }

    func continueButtonTouchUp() {
        self.performSegueWithIdentifier("exitIntroView", sender: self);
    }
}
