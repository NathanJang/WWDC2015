//
//  HomeViewController.swift
//  jonathan-chan
//
//  Created by Jonathan Chan on 2015-04-15.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    let numberOfPages = 5

    var scrollView = UIScrollView()

    // MARK: - Subviews in scroll view
    // MARK: Page 0: Photo + short bio
    var facePhotoImageView = {() -> UIImageView in
        var radius = 75
        var facePhotoImageView = UIImageView(frame: CGRectMake(0, 0, CGFloat(2 * radius), CGFloat(2 * radius)))
        facePhotoImageView.image = UIImage(named: "FacePhoto")

        // Make it circular
        facePhotoImageView.layer.cornerRadius = CGFloat(radius)
        facePhotoImageView.layer.masksToBounds = true

        // border
        facePhotoImageView.layer.borderColor = UIColor.blackColor().CGColor
        facePhotoImageView.layer.borderWidth = 2

        return facePhotoImageView
    }()
    var nameLabel = {() -> UILabel in
        var nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(32)
        nameLabel.text = "Jonathan Chan"
        nameLabel.sizeToFit()
        return nameLabel
    }()
    var bioLabel = {() -> UILabel in
        var bioLabel = UILabel()
        bioLabel.font = UIFont(name: helveticaNeueLightFontName, size: 32)
        bioLabel.text = "Student, 17\nProgrammer\nScientist"
        bioLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        bioLabel.textAlignment = NSTextAlignment.Center
        bioLabel.numberOfLines = 0
        bioLabel.sizeToFit()
        return bioLabel
    }()

    // MARK: - VC lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - self.tabBarController!.tabBar.frame.size.height)
        self.scrollView.contentSize.width = CGFloat(self.numberOfPages) * self.scrollView.frame.width
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)

        for index in 0..<self.numberOfPages {
            self.drawInitialPage(numbered: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Drawing initial pages

    // This horrible switch-case structure is so that we can get the page number easily so as to position more easily
    func drawInitialPage(numbered pageNumber: Int) {
        let frame = self.scrollView.frame

        switch pageNumber {

        case 0:
            // facePhotoImageView
            self.facePhotoImageView.center = CGPointMake(frame.width / 2, frame.height / 2 - 75)
            self.scrollView.addSubview(self.facePhotoImageView)

            // nameLabel
            self.nameLabel.center = CGPointMake(frame.width / 2, frame.height / 2 + 30)
            self.scrollView.addSubview(self.nameLabel)

            // bioLabel
            self.bioLabel.center = CGPointMake(frame.width / 2, frame.height / 2 + 115)
            self.scrollView.addSubview(self.bioLabel)
            break

        default:
            break
        }
    }

    // MARK: - Delegate methods
    // MARK: Scroll view

    func scrollViewDidScroll(scrollView: UIScrollView) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
