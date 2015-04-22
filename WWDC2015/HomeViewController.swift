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
    var swipeLeftView = {() -> UIView in
        var swipeLeftView = UIView()

        var label = UILabel()
        label.text = "slide to unlock"
        label.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        label.sizeToFit()
        label.textColor = UIColor.grayColor()
        swipeLeftView.addSubview(label)

        var icon = UIImageView(image: UIImage(named: "SwipeLeftIcon"))
        icon.frame.origin.x = label.frame.width + 5
        icon.center.y = label.center.y
        icon.tintColor = UIColor.grayColor()
        swipeLeftView.addSubview(icon)

        swipeLeftView.frame.size = CGSize(width: label.frame.width + icon.frame.width, height: icon.frame.height)

        return swipeLeftView
    }()

    // MARK: Page 1: Shanghai
    let blurredShanghaiBuildingsPhotoImage = UIImage(named: "BlurredShanghaiBuildingsPhoto")

    var eleventhGraderLabel = {() -> UILabel in
        var eleventhGraderLabel = UILabel()
        eleventhGraderLabel.text = "AN 11TH GRADER AT"
        eleventhGraderLabel.font = UIFont(name: "Avenir-Book", size: 24)
        eleventhGraderLabel.textColor = UIColor(red: 0.067, green: 0.733, blue: 1, alpha: 1)
        eleventhGraderLabel.sizeToFit()
        return eleventhGraderLabel
    }()
    var 上海美國學校標籤 = {() -> UILabel in
        var 上海美國學校標籤 = UILabel()
        上海美國學校標籤.text = "Shanghai\nAmerican\nSchool"
        上海美國學校標籤.font = UIFont(name: "Avenir-Book", size: 32)
        上海美國學校標籤.numberOfLines = 3
        上海美國學校標籤.textAlignment = NSTextAlignment.Right
        上海美國學校標籤.textColor = UIColor.whiteColor()
        上海美國學校標籤.sizeToFit()
        return 上海美國學校標籤
    }()

    // MARK: Page 2: Coding
    var shouldAnimatePage2 = false

    var laptopIconImageView = {() -> UIImageView in
        var laptopIconImageView = UIImageView()
        laptopIconImageView.image = UIImage(named: "LaptopIcon")
        laptopIconImageView.sizeToFit()
        return laptopIconImageView
    }()
    var codeLanguageLogoArray: [UIView] = [
        UIImageView(image: UIImage(named: "JavascriptLogo")),
        UIImageView(image: UIImage(named: "NodeLogo")),
        UIImageView(image: UIImage(named: "PHPLogo")),
        UIImageView(image: UIImage(named: "HTML5Logo")),
        {() -> UIView in
            var objectiveCSwiftView = UIView()
            var objectiveCLabel = UILabel(), swiftLabel = UILabel()
            let font = UIFont(name: "HelveticaNeue-Light", size: 32)
            objectiveCLabel.font = font
            swiftLabel.font = font
            objectiveCLabel.text = "Objective-C"
            swiftLabel.text = "Swift"
            objectiveCLabel.textColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
            swiftLabel.textColor = UIColor(red: 0.988, green: 0.282, blue: 0.192, alpha: 1)
            objectiveCLabel.sizeToFit()
            swiftLabel.sizeToFit()
            let spacing: CGFloat = 10
            swiftLabel.frame.origin.y = objectiveCLabel.frame.size.height + spacing
            swiftLabel.center.x = objectiveCLabel.center.x
            objectiveCSwiftView.addSubview(objectiveCLabel)
            objectiveCSwiftView.addSubview(swiftLabel)
            objectiveCSwiftView.frame.size = CGSize(width: objectiveCLabel.frame.size.width, height: objectiveCLabel.frame.size.height + swiftLabel.frame.size.height + spacing)
            return objectiveCSwiftView
        }()
    ]
    var codeLanguageLogoScrollView = UIScrollView()

    let codingLabelText: String = "I like to code. "
    var codingLabel = {() -> UILabel in
        var codingLabel = UILabel()
        codingLabel.font = UIFont(name: "Menlo-Regular", size: 28)
        return codingLabel
    }()
    var codingLabelCursor = {() -> UILabel in
        var codingLabelCursor = UILabel()
        codingLabelCursor.text = " "
        codingLabelCursor.backgroundColor = UIColor.grayColor()
        return codingLabelCursor
    }()
    var blinkCodingLabelCursorTimer: NSTimer?
    var swipeCodeLanguageLogoScrollViewTimer: NSTimer?
    var didBeginAnimatingPage2 = false

    // MARK: Page 3: GitHub
    var contributingOnGithubLabel = {() -> UILabel in
        var contributingOnGithubLabel = UILabel()
        contributingOnGithubLabel.text = "I contribute on"
        contributingOnGithubLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 42)
        contributingOnGithubLabel.sizeToFit()
        contributingOnGithubLabel.textColor = UIColor.whiteColor()
        return contributingOnGithubLabel
    }()
    var githubMarkImageView = UIImageView(image: UIImage(named: "GithubMark"))
    var githubProfileButton = {() -> UIButton in
        var githubProfileButton = UIButton()
        var text = NSMutableAttributedString(string: "Tap to\ncheckout my profile.")
        text.addAttribute(NSFontAttributeName, value: UIFont(name: "Courier", size: 18)!, range: NSRange(location: 7, length: 8))
        githubProfileButton.setAttributedTitle(text, forState: UIControlState.Normal)
        githubProfileButton.titleLabel!.textAlignment = NSTextAlignment.Center
        githubProfileButton.titleLabel!.numberOfLines = 2
        githubProfileButton.backgroundColor = UIColor(red: 0.945, green: 0.965, blue: 0.984, alpha: 1)
        githubProfileButton.setTitleColor(UIColor(red: 0.0141, green: 0.31, blue: 0.475, alpha: 1), forState: UIControlState.Normal)
        githubProfileButton.titleLabel!.sizeToFit()
        githubProfileButton.frame.size = CGSize(width: 200, height: 50)
        githubProfileButton.layer.cornerRadius = githubProfileButton.frame.height / 2 // rounded sides
        githubProfileButton.layer.masksToBounds = true
        return githubProfileButton
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

        for pageNumber in 0..<self.numberOfPages {
            self.drawInitialPage(numbered: pageNumber)
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
                self.facePhotoImageView.center = CGPoint(x: center.x, y: center.y - 120)
                self.scrollView.addSubview(self.facePhotoImageView)

                // nameLabel
                self.nameLabel.center.x = center.x
                self.nameLabel.frame.origin.y = center.y - 30
                self.scrollView.addSubview(self.nameLabel)

                // bioLabel
                self.bioLabel.center.x = center.x
                self.bioLabel.frame.origin.y = center.y + 10
                self.scrollView.addSubview(self.bioLabel)

                // swipeLeftView
                self.swipeLeftView.center.x = center.x
                //self.swipeLeftView.frame.origin.y = self.bioLabel.frame.origin.y + self.bioLabel.frame.height + 20
                self.swipeLeftView.center.y = ((self.bioLabel.frame.origin.y + self.bioLabel.frame.height) + (frame.height - self.tabBarController!.tabBar.frame.height)) / 2
                self.scrollView.addSubview(self.swipeLeftView)

            case 1:
                self.eleventhGraderLabel.center.x = center.x
                self.eleventhGraderLabel.frame.origin.y = 30
                self.scrollView.addSubview(self.eleventhGraderLabel)

                self.上海美國學校標籤.frame.origin = CGPoint(x: self.eleventhGraderLabel.frame.origin.x + self.eleventhGraderLabel.frame.width - self.上海美國學校標籤.frame.width, y: 70)
                self.scrollView.addSubview(self.上海美國學校標籤)

            case 2:
                // Set the text...
                self.codingLabel.text = self.codingLabelText
                // size & frame it...
                self.codingLabel.sizeToFit()
                self.codingLabel.center.x = center.x
                self.codingLabel.frame.origin.y = center.y + 75
                // and then clear the text so we can add it animated.
                self.codingLabel.text = ""
                self.scrollView.addSubview(self.codingLabel)

                self.codingLabelCursor.font = self.codingLabel.font
                self.codingLabelCursor.sizeToFit()
                self.codingLabelCursor.frame.origin = self.codingLabel.frame.origin
                self.scrollView.addSubview(self.codingLabelCursor)

                self.laptopIconImageView.center = CGPoint(x: center.x, y: center.y - 50)
                self.scrollView.addSubview(self.laptopIconImageView)

                self.codeLanguageLogoScrollView.frame.origin.y = self.laptopIconImageView.frame.origin.y + 30
                self.codeLanguageLogoScrollView.frame.size = CGSize(width: 204, height: 122)
                self.codeLanguageLogoScrollView.center.x = self.laptopIconImageView.center.x
                self.codeLanguageLogoScrollView.contentSize = CGSize(width: CGFloat(self.codeLanguageLogoArray.count) * self.codeLanguageLogoScrollView.frame.width, height: self.codeLanguageLogoScrollView.frame.height)
                for index in 0..<self.codeLanguageLogoArray.count {
                    let center = CGPoint(x: (CGFloat(index) + 0.5) * self.codeLanguageLogoScrollView.frame.width, y: self.codeLanguageLogoScrollView.frame.height / 2)
                    self.codeLanguageLogoArray[index].center = center
                    self.codeLanguageLogoScrollView.addSubview(self.codeLanguageLogoArray[index])
                }
                self.codeLanguageLogoScrollView.userInteractionEnabled = false
                self.codeLanguageLogoScrollView.showsHorizontalScrollIndicator = false
                self.scrollView.addSubview(self.codeLanguageLogoScrollView)

            case 3:
                self.githubMarkImageView.center = center
                self.scrollView.addSubview(self.githubMarkImageView)

                self.contributingOnGithubLabel.center = CGPoint(x: center.x, y: self.githubMarkImageView.frame.origin.y - 40)
                self.scrollView.addSubview(self.contributingOnGithubLabel)

                self.githubProfileButton.addTarget(self, action: "openGithubProfile", forControlEvents: UIControlEvents.TouchUpInside)
                self.githubProfileButton.center.x = center.x
                self.githubProfileButton.frame.origin.y = self.githubMarkImageView.frame.origin.y + self.githubMarkImageView.frame.height + 30
                self.scrollView.addSubview(self.githubProfileButton)

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
                self.shouldAnimatePage2 = false

                hasBackground = true
                self.backgroundBackView.image = self.blurredShanghaiBuildingsPhotoImage
                self.backgroundFrontView.image = nil
                self.backgroundFrontView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(offsetPercentage)

                // Fixes when user scrolls too quickly for tab bar frame to update
                self.tabBarController!.tabBar.frame.origin.y = self.view.bounds.size.height

            case 2:
                if offsetPercentage < 0.5 {
                    setDefaultStatusBarStyle()
                } else {
                    setLightStatusBarStyle()
                }
                self.shouldAnimatePage2 = true

                hasBackground = true
                self.backgroundBackView.image = nil
                self.backgroundBackView.backgroundColor = UIColor.whiteColor()
                self.backgroundFrontView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(offsetPercentage)

                if !self.didBeginAnimatingPage2 {
                    self.didBeginAnimatingPage2 = true
                    self.beginAnimatingPage2()
                    self.swipeCodeLanguageLogoScrollViewTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "swipeCodeLanguageLogoScrollView", userInfo: nil, repeats: true)
                }

            case 3:
                if offsetPercentage < 0.5 {
                    setLightStatusBarStyle()
                } else {
                    setDefaultStatusBarStyle()
                }
                self.shouldAnimatePage2 = false

                hasBackground = true
                self.backgroundBackView.backgroundColor = UIColor.blackColor()
                self.backgroundFrontView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(offsetPercentage)

            default:
                break
        }

        // Separate switch-case so animations on the last pages can be included separately from their own animations
        switch pageNumber {

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

    // MARK: Individual page animations

    // MARK: Page 2

    func beginAnimatingPage2() {
        self.didBeginAnimatingPage2 = true
        self.blinkCodingLabelCursorTimer = self.getBlinkCodingLabelCursorTimer()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "initialCodingLabelCursorBlinkingDidFinish", userInfo: nil, repeats: false)
    }

    func getBlinkCodingLabelCursorTimer() -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "blinkCodingLabelCursor", userInfo: nil, repeats: true)
    }

    func initialCodingLabelCursorBlinkingDidFinish() {
        self.blinkCodingLabelCursorTimer?.invalidate()
        self.beginTypingCodingLabelText()
    }

    func beginTypingCodingLabelText() {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "appendCharacterToCodingLabel:", userInfo: nil, repeats: true)
    }

    func appendCharacterToCodingLabel(sender: NSTimer) {
        if self.shouldAnimatePage2 {
            self.codingLabel.text = (self.codingLabelText as NSString).substringToIndex(count(self.codingLabel.text!) + 1)

            if (self.codingLabel.text == self.codingLabelText) {
                sender.invalidate()
                self.blinkCodingLabelCursorTimer = self.getBlinkCodingLabelCursorTimer()
            } else {
                self.codingLabelCursor.frame.origin.x += self.codingLabelCursor.frame.width
            }
        }
    }

    func blinkCodingLabelCursor() {
        if self.shouldAnimatePage2 {
            self.codingLabelCursor.alpha = CGFloat(!Bool(self.codingLabelCursor.alpha))
        }
    }

    func swipeCodeLanguageLogoScrollView() {
        if self.shouldAnimatePage2 {
            let numberOfPages = self.codeLanguageLogoArray.count
            let pageWidth = self.codeLanguageLogoScrollView.frame.width
            let currentPageNumber = Int(self.codeLanguageLogoScrollView.contentOffset.x / pageWidth)
            if currentPageNumber != numberOfPages - 1 {
                self.codeLanguageLogoScrollView.setContentOffset(CGPoint(x: CGFloat(currentPageNumber + 1) * pageWidth, y: 0), animated: true)
            } else {
                self.codeLanguageLogoScrollView.setContentOffset(CGPointZero, animated: true)
            }
        }
    }

    // MARK: Page 3

    func openGithubProfile() {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://gist.github.com/NathanJang/d3320e30c1cd997fb463")!) // Opens a gist proving the account is mine
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
