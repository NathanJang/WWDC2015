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
    var backgroundFrontView = UIView()
    var backgroundBackView = UIView()

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
        bioLabel.font = UIFont(name: helveticaNeueLightFontName, size: 32)
        bioLabel.text = "Student, 17\nProgrammer\nScientist"
        bioLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        bioLabel.textAlignment = NSTextAlignment.Center
        bioLabel.numberOfLines = 0
        bioLabel.sizeToFit()
        return bioLabel
    }()

    // MARK: Page 1: Cityscape
    var colorWithBlurredShanghaiCityscapePhoto = {() -> UIColor in
        return UIColor(patternImage: UIImage(named: "BlurredShanghaiCityscapePhoto")!)
    }()

    // MARK: - VC lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.backgroundBackView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
        self.view.addSubview(self.backgroundBackView)
        self.backgroundFrontView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
        self.view.addSubview(self.backgroundFrontView)

        self.scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
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

        switch pageNumber {

            case 0:
                // facePhotoImageView
                self.facePhotoImageView.center = CGPoint(x: frame.width / 2, y: frame.height / 2 - 75)
                self.scrollView.addSubview(self.facePhotoImageView)

                // nameLabel
                self.nameLabel.center.x = frame.width / 2
                self.nameLabel.frame.origin.y = frame.height / 2 + 15
                self.scrollView.addSubview(self.nameLabel)

                // bioLabel
                self.bioLabel.center.x = frame.width / 2
                self.bioLabel.frame.origin.y = frame.height / 2 + 55
                self.scrollView.addSubview(self.bioLabel)

            default:
                break
        }
    }

    // MARK: Animations

    func animateIntermediatePage(numbered pageNumber: Int, offsetPercentage: CGFloat, scrollView: UIScrollView) {

        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height

        switch pageNumber {

            case 0:
                self.backgroundBackView.backgroundColor = UIColor.clearColor()
                self.backgroundFrontView.backgroundColor = self.colorWithBlurredShanghaiCityscapePhoto.colorWithAlphaComponent(offsetPercentage)

                if offsetPercentage >= 0 {
                    self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height - (1 - offsetPercentage) * tabBarHeight
                }

            case 1:
                self.backgroundBackView.backgroundColor = self.colorWithBlurredShanghaiCityscapePhoto
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
                self.backgroundBackView.backgroundColor = UIColor.clearColor()
                self.backgroundFrontView.backgroundColor = UIColor.clearColor()
        }
    }

    // MARK: - Delegate methods
    // MARK: Scroll view

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPageNumber = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(self.numberOfPages))
        let offsetPercentage = scrollView.contentOffset.x / scrollView.frame.width - CGFloat(currentPageNumber)
        self.animateIntermediatePage(numbered: currentPageNumber, offsetPercentage: offsetPercentage, scrollView: scrollView)
    }

}
