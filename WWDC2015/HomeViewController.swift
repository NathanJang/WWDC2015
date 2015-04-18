//
//  HomeViewController.swift
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-15.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    let numberOfPages = 5

    var scrollView = UIScrollView()
    // These are 2 views behind the scroll view.
    // The front view's alpha is adjusted according to scrolling offset to create a mix of both colors (GSTQ) or images.
    var backgroundFrontView = {() -> UIImageView in
        var backgroundFrontView = UIImageView()
        backgroundFrontView.contentMode = UIViewContentMode.ScaleAspectFill
        return backgroundFrontView
    }()
    var backgroundBackView = {() -> UIImageView in
        var backgroundBackView = UIImageView()
        backgroundBackView.contentMode = UIViewContentMode.ScaleAspectFill
        return backgroundBackView
    }()

    // MARK: - Subviews in scroll view
    // MARK: Page 0: Photo + short bio
    var facePhotoImageView = {() -> UIImageView in
        var radius = 75
        var facePhotoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: CGFloat(2 * radius), height: CGFloat(2 * radius)))
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
        bioLabel.font = UIFont(name: "HelveticaNeue-Light", size: 32)
        bioLabel.text = "Student, 17\nProgrammer\nScientist"
        bioLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        bioLabel.textAlignment = NSTextAlignment.Center
        bioLabel.numberOfLines = 0
        bioLabel.sizeToFit()
        return bioLabel
    }()

    // MARK: Page 1: Cityscape
    let blurredShanghaiBuildingsPhotoImage = UIImage(named: "BlurredShanghaiBuildingsPhoto")

    var eleventhGraderLabel = {() -> UILabel in
        var eleventhGraderLabel = UILabel()
        eleventhGraderLabel.text = "AN 11TH GRADER AT"
        eleventhGraderLabel.font = UIFont(name: "Avenir-Book", size: 24)
        eleventhGraderLabel.textColor = UIColor(red: 0.184, green: 0.6, blue: 0.851, alpha: 1)
        eleventhGraderLabel.sizeToFit()
        return eleventhGraderLabel
    }()
    var sasLabel = {() -> UILabel in
        var sasLabel = UILabel()
        sasLabel.text = "Shanghai\nAmerican\nSchool"
        sasLabel.font = UIFont(name: "Avenir-Book", size: 32)
        sasLabel.numberOfLines = 3
        sasLabel.textAlignment = NSTextAlignment.Right
        sasLabel.textColor = UIColor.whiteColor()
        sasLabel.sizeToFit()
        return sasLabel
    }()

    // MARK: - VC lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.backgroundBackView.frame = CGRect(origin: CGPointZero, size: self.view.bounds.size)
        self.view.addSubview(self.backgroundBackView)
        self.backgroundFrontView.frame = CGRect(origin: CGPointZero, size: self.view.bounds.size)
        self.view.addSubview(self.backgroundFrontView)

        self.scrollView.frame = CGRect(origin: CGPointZero, size: self.view.bounds.size)
        self.scrollView.contentSize.width = CGFloat(self.numberOfPages) * self.scrollView.frame.width
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)

        for page in 0..<self.numberOfPages {
            self.drawInitialPage(numbered: page)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Layout

    // This horrible switch-case structure is so that we can group things together and get a page number to work with.
    func drawInitialPage(numbered pageNumber: Int) {
        let frame = self.scrollView.frame
        let center = CGPoint(x: frame.width * (CGFloat(pageNumber) + 0.5), y: frame.height / 2)

        switch pageNumber {

            case 0:
                // facePhotoImageView
                self.facePhotoImageView.center = CGPoint(x: center.x, y: center.y - 100)
                self.scrollView.addSubview(self.facePhotoImageView)

                // nameLabel
                self.nameLabel.center.x = center.x
                self.nameLabel.frame.origin.y = center.y - 10
                self.scrollView.addSubview(self.nameLabel)

                // bioLabel
                self.bioLabel.center.x = center.x
                self.bioLabel.frame.origin.y = center.y + 30
                self.scrollView.addSubview(self.bioLabel)

            case 1:
                self.eleventhGraderLabel.center.x = center.x
                self.eleventhGraderLabel.frame.origin.y = 30
                self.scrollView.addSubview(self.eleventhGraderLabel)

                self.sasLabel.frame.origin = CGPoint(x: self.eleventhGraderLabel.frame.origin.x + self.eleventhGraderLabel.frame.width - self.sasLabel.frame.width, y: 70)
                self.scrollView.addSubview(self.sasLabel)

            default:
                break
        }
    }

    // MARK: Animations

    func animateIntermediatePage(numbered pageNumber: Int, offsetPercentage: CGFloat, scrollView: UIScrollView) {

        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height

        var hasBackground = false
        func clearBackground() {
            self.backgroundBackView.backgroundColor = UIColor.clearColor()
            self.backgroundBackView.image = nil
            self.backgroundFrontView.backgroundColor = UIColor.clearColor()
            self.backgroundFrontView.image = nil
        }

        switch pageNumber {

            case 0:
                if offsetPercentage < 0.5 {
                    setDefaultStatusBarStyle()
                } else {
                    setLightStatusBarStyle()
                }

                hasBackground = true
                self.backgroundBackView.image = nil
                self.backgroundFrontView.image = self.blurredShanghaiBuildingsPhotoImage
                self.backgroundFrontView.alpha = offsetPercentage

                if offsetPercentage >= 0 {
                    self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height - (1 - offsetPercentage) * tabBarHeight
                }

            case 1:
                if offsetPercentage < 0.5 {
                    setLightStatusBarStyle()
                } else {
                    setDefaultStatusBarStyle()
                }

                hasBackground = true
                self.backgroundBackView.image = self.blurredShanghaiBuildingsPhotoImage
                self.backgroundFrontView.image = nil
                self.backgroundFrontView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(offsetPercentage)

                // Fixes when user scrolls too quickly for tab bar frame to update
                self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height

            case self.numberOfPages - 3:
                // Fixes when user scrolls too quickly for tab bar frame to update
                self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height

            case self.numberOfPages - 2:
                self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height - offsetPercentage * tabBarHeight

            case self.numberOfPages - 1:
                self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height - tabBarHeight

            default:
                break
        }

        // Fixes when user scrolls too quickly for background to update
        if !hasBackground {
            clearBackground()
        }
    }

    // MARK: - Delegate methods
    // MARK: Scroll view

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPageNumber = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(self.numberOfPages))
        let offsetPercentage = scrollView.contentOffset.x / scrollView.frame.width - CGFloat(currentPageNumber)
        self.animateIntermediatePage(numbered: currentPageNumber, offsetPercentage: offsetPercentage, scrollView: scrollView)

        if currentPageNumber == 0 && offsetPercentage == 0 || currentPageNumber == self.numberOfPages - 1 {
            self.tabBarController?.tabBar.userInteractionEnabled = true
        } else {
            self.tabBarController?.tabBar.userInteractionEnabled = false
        }
    }

}
