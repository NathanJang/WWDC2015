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
    var helloLabel = {() -> UILabel in
        var helloLabel = UILabel()
        helloLabel.font = UIFont(name: helveticaNeueUltraLightFontName, size: 72)
        helloLabel.text = "Hello."
        helloLabel.sizeToFit()
        return helloLabel
    }()
    var subtitleLabel = {() -> UILabel in
        var subtitleLabel = UILabel()
        subtitleLabel.font = UIFont(name: helveticaNeueUltraLightFontName, size: 24)
        subtitleLabel.text = "Jonathan Chan\nWWDC 2015"
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subtitleLabel.sizeToFit()
        subtitleLabel.textAlignment = NSTextAlignment.Center
        subtitleLabel.alpha = 0
        return subtitleLabel
    }()
    var continueButton = {() -> UIButton in
        var continueButton = UIButton()
        continueButton.setBackgroundImage(UIImage(named: "RightArrow"), forState: UIControlState.Normal)
        continueButton.sizeToFit()
        continueButton.alpha = 0
        return continueButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.helloLabel.center = self.view.center
        self.subtitleLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 15)
        self.continueButton.center = CGPointMake(self.view.center.x, self.view.center.y + 100)
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
        continueButton.addTarget(self, action: "continueButtonTouchUp", forControlEvents: UIControlEvents.TouchUpInside)

        UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.helloLabel.center.y += -75
            self.subtitleLabel.alpha = 1
            self.continueButton.alpha = 1
        }, completion: nil)
    }

    func continueButtonTouchUp() {
        self.performSegueWithIdentifier("exitIntroView", sender: self);
    }
}
