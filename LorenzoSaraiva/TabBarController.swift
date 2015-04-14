//
//  TabBarController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/14/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
   
    override func viewDidLoad()
    {
        let tabItems = self.tabBar.items as! [UITabBarItem]
        let tabItem0 = tabItems[0] as UITabBarItem
        let tabItem1 = tabItems[1] as UITabBarItem
        let tabItem2 = tabItems[2] as UITabBarItem
        let tabItem3 = tabItems[3] as UITabBarItem
        let tabItem4 = tabItems[4] as UITabBarItem
        
       
        tabItem0.title = "Profile"
        tabItem1.title = "About Me"
        tabItem2.title = "Background"
        tabItem3.title = "Skills"
        tabItem4.title = "Other"
    }

}
