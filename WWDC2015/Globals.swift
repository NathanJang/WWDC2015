//
//  Globals.swift
//  WWDC2015
//
//  Created by Jonathan Chan on 2015-04-16.
//  Copyright (c) 2015 Jonathan Chan. All rights reserved.
//

import UIKit

func setDefaultStatusBarStyle() {
    let application = UIApplication.sharedApplication()
    if application.statusBarStyle != UIStatusBarStyle.Default {
        application.setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    }
}

func setLightStatusBarStyle() {
    let application = UIApplication.sharedApplication()
    if application.statusBarStyle != UIStatusBarStyle.LightContent {
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
}
