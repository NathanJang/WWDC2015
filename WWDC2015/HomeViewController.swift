//
//  HomeViewController.swift
//  jonathan-chan
//
//  Created by Jonathan Chan on 2015-04-15.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    let numberOfPages = 3

    var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - self.tabBarController!.tabBar.frame.size.height)
        self.scrollView.contentSize.width = CGFloat(self.numberOfPages) * self.view.bounds.width
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
