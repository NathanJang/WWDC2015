//
//  AboutViewController.swift
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-15.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    let margin: CGFloat = 10

    var acknowledgmentsLabel = {() -> UILabel in
        var acknowledgmentsLabel = UILabel()
        let path = NSBundle.mainBundle().pathForResource("Acknowledgments", ofType: "txt") as String!
        let text = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        acknowledgmentsLabel.text = text as? String
        acknowledgmentsLabel.numberOfLines = 0
        acknowledgmentsLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return acknowledgmentsLabel
    }()

    var attributionsLabel = {() -> UILabel in
        var attributionsLabel = UILabel()
        let path = NSBundle.mainBundle().pathForResource("Attributions", ofType: "txt") as String!
        let text = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        attributionsLabel.text = text as? String
        attributionsLabel.numberOfLines = 0
        attributionsLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return attributionsLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.acknowledgmentsLabel.frame.size.width = self.view.frame.width - 2 * self.margin
        self.acknowledgmentsLabel.sizeToFit()
        self.acknowledgmentsLabel.frame.origin = CGPoint(x: self.margin, y: self.margin)
        self.scrollView.addSubview(self.acknowledgmentsLabel)

        self.attributionsLabel.frame.size.width = self.view.frame.width - 2 * self.margin
        self.attributionsLabel.sizeToFit()
        self.attributionsLabel.frame.origin = CGPoint(x: self.margin, y: self.acknowledgmentsLabel.frame.size.height + self.margin)
        self.scrollView.addSubview(self.attributionsLabel)

        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.acknowledgmentsLabel.frame.height + self.attributionsLabel.frame.height + self.margin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
