//
//  TTTabBar.swift
//  Tutton
//
//  Created by Eduardo Iglesias on 3/6/15.
//  Copyright (c) 2015 Tutton. All rights reserved.
//

import UIKit

class TTTabBar: UIViewController {
    
    private var detailView: UIView! //View that will show controllers
    private var activeTabBar: TTTabBarItem? //Active showing view Controller
    private var tabBarView: UIView! //View of tabBar
    private var contentTabBarView : UIView! //Content, where background is render
    
    //TabBar Items, which include VC
    var tabBarItems: [TTTabBarItem] = []
    
    private let defaultTabBarHeight: CGFloat = 40
    private var initialTabBarHeight: CGFloat = 0
    
    //TabBar Custom
    var tabBarHeight: CGFloat = 0 //Height of the TabBar, if a TTTabBarItem is bigger, will be over the tabBar
    var defaultTabBarItem: TTTabBarItem!
    var spaceBetweenTabs: CGFloat = 5
    var tabBackgroundColor = UIColor.whiteColor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Defaults
        tabBarHeight = defaultTabBarHeight
        initialTabBarHeight = tabBarHeight
        
        //Create the detailView
        detailView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-tabBarHeight))
        
        //Creat TabBar view
        tabBarView = UIView(frame: CGRectMake(0, self.view.frame.height-tabBarHeight, self.view.frame.width, tabBarHeight))
        contentTabBarView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, tabBarHeight))
        
        //defaults
        tabBarView.backgroundColor = UIColor.clearColor()
        
        //Add subviews to mainView
        tabBarView.addSubview(contentTabBarView)
        self.view.addSubview(detailView)
        self.view.addSubview(tabBarView)
    }
    
    //Modify tabbar with custom options
    func updateTabBarView() {
        
        //Update the detailView
        detailView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-tabBarHeight)
        
        //Update TabBar view
        tabBarView.frame = CGRectMake(0, self.view.frame.height-tabBarHeight, self.view.frame.width, tabBarHeight)
        
        //Verify that has defaultTabBar
        if let tabBar = defaultTabBarItem {
            
        }else{
            if tabBarItems.count > 0 {
                defaultTabBarItem = tabBarItems[0]
            }
        }
        
        self.updateBackgroundColor(tabBackgroundColor)
        self.updateTabBarHeight()
        self.renderButtons()
    }
    
    private func updateBackgroundColor (color: UIColor) {
        contentTabBarView.backgroundColor = color
    }
    
    func updateTabBarHeight() {
        for tabBarItem in tabBarItems {
            
            //if one button is greather default. Set the tabBarView greather
            if tabBarItem.frame.height + tabBarItem.offsetBottom > tabBarView.frame.height {
                tabBarHeight = tabBarItem.frame.height + tabBarItem.offsetBottom
                tabBarView.frame = CGRectMake(0, self.view.frame.height-tabBarHeight, self.view.frame.width, tabBarHeight)
                contentTabBarView.frame = CGRectMake(0, tabBarHeight-initialTabBarHeight, self.view.frame.width, initialTabBarHeight)
                
                
            }
        }
    }
    
    private func renderButtons() {
        
        //Get all TabBarItems and divide the width between
        let widthPerButton = (self.view.frame.width - spaceBetweenTabs*CGFloat(tabBarItems.count))/CGFloat(tabBarItems.count)
        
        //Add subview buttons to tabBar
        var tempX = spaceBetweenTabs //Start position of buttons, logical position
        for tabBarItem in tabBarItems {
            //Set images if has
            if let image = tabBarItem.image {
                tabBarItem.setImage(image, forState: UIControlState.Normal)
            }
            
            if defaultTabBarItem == tabBarItem {
                //Load the default VC
                self.loadViewControllerFrom(tabBarItem)
            }
            
            //Call action on touchUpInside
            tabBarItem.addTarget(self, action: "tabBarItemClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            //if the height of the tabBarItem, is default (40), change to tabBarView height
            var newHeight = tabBarItem.frame.height
            if tabBarItem.frame.height == defaultTabBarHeight {
                newHeight = defaultTabBarHeight
            }
            
            //if width of tanBarItem is not 0, set the custom size
            var customWidth = widthPerButton
            var positionX = tempX
            if tabBarItem.frame.width > 0 {
                customWidth = tabBarItem.frame.width
                
                //New position of X
                //Center button on distance between buttons + custom width
                positionX = tempX + widthPerButton/2 - customWidth/2
            }
            
            //Modify frame of TabBarItems
            //- tabBarItem.offsetBottom
            let off = (tabBarView.frame.height - tabBarItem.frame.height) - tabBarItem.offsetBottom
            tabBarItem.frame = CGRectMake(positionX, tabBarItem.offsetY + off , customWidth, newHeight)
            tempX += widthPerButton+spaceBetweenTabs
            
            tabBarView.addSubview(tabBarItem)
        }
    }
    
    func tabBarItemClicked(sender: AnyObject) {
        if let tabBar = sender as? TTTabBarItem {
            self.loadViewControllerFrom(tabBar)
        }
    }
    
    func loadViewControllerFrom(tabBarItem: TTTabBarItem?) {
        if let item = tabBarItem {
            if !self.ttTabBar(self, shouldChangeTab: item) {
                return
            }
            
            //if users click on the same tab that is active, return
            if let tabBar = activeTabBar {
                if item == activeTabBar {
                    return
                }
            }
        }
        
        //Change image to the old tabBarItem to no selected
        if let tabBar = activeTabBar {
            ttTabBar(self, tabWillDisappear: tabBar)
            if let image = tabBar.image {
                tabBar.setImage(image, forState: UIControlState.Normal)
            }
            
            //Remove actual View
            if let vc = tabBar.viewController {
                vc.view.removeFromSuperview()
            }
            ttTabBar(self, tabDidDisappear: tabBar)
        }
        
        if let item = tabBarItem {
            //Change image to the new tabBarItem to selected
            if let image = item.selectedImage {
                item.setImage(image, forState: UIControlState.Normal)
            }
            
            
            //add VC to detailView
            if let vc = item.viewController {
                ttTabBar(self, tabWillAppear: item)
                //set active bar
                activeTabBar = item
                
                vc.view.frame = self.detailView.bounds
                detailView.addSubview(vc.view)
                self.addChildViewController(vc)
                vc.didMoveToParentViewController(self)
                
                ttTabBar(self, tabDidAppear: item)
            }
        }
    }
    
    //IF you need to load an external view controller, that is not on the tab menu
    func loadViewController(vc: UIViewController) {
        //Change image to the old tabBarItem to no selected
        if let tabBar = activeTabBar {
            ttTabBar(self, tabWillDisappear: tabBar)
            if let image = tabBar.image {
                tabBar.setImage(image, forState: UIControlState.Normal)
            }
            
            //Remove actual View
            if let vc = tabBar.viewController {
                vc.view.removeFromSuperview()
            }
            ttTabBar(self, tabDidDisappear: tabBar)
        }
        
        //add VC to detailView
        //set active bar
        activeTabBar = nil
        
        vc.view.frame = self.detailView.bounds
        detailView.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
    }
    
    //MARK: overridable Func
    internal func ttTabBar(tabBar: TTTabBar, shouldChangeTab tabBarItem: TTTabBarItem) -> Bool {
        if tabBarItem.isButton {
            self.ttTabBar(tabBar, buttonHasBeenClicked: tabBarItem)
            return false
        }
        
        return true
    }
    
    internal func ttTabBar(tabBar: TTTabBar, tabWillDisappear tabBarItem: TTTabBarItem) {
        
    }
    
    internal func ttTabBar(tabBar: TTTabBar, tabDidDisappear tabBarItem: TTTabBarItem) {
        
    }
    
    internal func ttTabBar(tabBar: TTTabBar, tabWillAppear tabBarItem: TTTabBarItem) {
        
    }
    
    internal func ttTabBar(tabBar: TTTabBar, tabDidAppear tabBarItem: TTTabBarItem) {
        
    }
    
    internal func ttTabBar(tabBar: TTTabBar, buttonHasBeenClicked tabBarItem: TTTabBarItem) {
        
    }
}
