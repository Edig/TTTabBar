//
//  TTTabBarItem.swift
//  Tutton
//
//  Created by Eduardo Iglesias on 3/6/15.
//  Copyright (c) 2015 CreApps. All rights reserved.
//

import UIKit

class TTTabBarItem: UIButton {
    
    var offsetY: CGFloat = 0 //Offset from Top Y
    var offsetBottom: CGFloat = 0 //Offset from Bottom, like margin
    
    var image: UIImage?
    var selectedImage: UIImage?
    var viewController: UIViewController?
    
    //If is a button, set to yes
    var isButton = false
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    //Init with default size
    init(image: UIImage?, selected: UIImage?) {
        super.init(frame: CGRectMake(0, 0, 0, 40))
        self.setImage(image, forState: UIControlState.Normal)
        self.image = image
        self.selectedImage = selected
    }
    
    init(viewController: UIViewController) {
        super.init(frame: CGRectMake(0, 0, 0, 40))
        self.viewController = viewController
    }
    

}
