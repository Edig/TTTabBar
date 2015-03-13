# TTTabBar
TabBar with small icons and buttons like Facebook.

![alt tag](https://raw.github.com/edig/tttabbar/master/tabExample.png)

TTTabBar allows you to create a Tab Bar with:

- Differents sizes for every single tab
- Set each element of the tab as tab or button
- Update the tabBar size, color, elments at any time

Configurations:
- Tab Background
- Image for every tab
- Image for the selected tab
- Bakcground for every tab button
- Offset Bottom. Get an element with an offset from the bottom
- Offset Y. Get an element with an offset from the top of the tab bar
- Custom farme sizes of each element

No supported:
- Storyboards 
- Only support up to 5 items

How it works:

1. Subclass a UIViewController with TTTabBar, it can be in storyboard (TTTabBar is a subclass of UIViewController)

2. Create the Tab Bar Items, with TTTabBarItem
- You can init this with a viewController or with images
- I recommend that if the item of the tab is a tab initialize with a ViewController, if the element is a button initialize with a image
- Then you need to set the image and selected image

```
//Tab. VC -> UIViewController or subclass
let item = TTTabBarItem(viewController: vc)
item.image = UIImage(named: "image")
item.selectedImage = UIImage(named: "image_selected")

//Button
let item3 = TTTabBarItem(image: UIImage(named: "image"), selected: UIImage(named: image_selected"))
item3.isButton = true

//Configurations
item3.offsetBottom = 5
item3.offsetY = 5m
item3.backgroundColor = UIColor.blackColor()
item3.frame = CGRectMake(0, 0, 55, 55)
```

3. Configure TabBar

```
self.tabBackgroundColor = UIColor.lightGrayColor()
```

4. Set the elements to the tab bar. Now it supports up to 5

```
self.tabBarItems = [item, item2, item3, item4, item5]
```

5. Finally call updateTabBarView, every single time you make a change to the tabBar

```
self.updateTabBarView()
```

Because you subclass TTTabBar, you can override the next functions

```
//Default true
override func ttTabBar(tabBar: TTTabBar, shouldChangeTab tabBarItem: TTTabBarItem) -> Bool 

override func ttTabBar(tabBar: TTTabBar, tabWillDisappear tabBarItem: TTTabBarItem) 

override func ttTabBar(tabBar: TTTabBar, tabDidDisappear tabBarItem: TTTabBarItem) 

override func ttTabBar(tabBar: TTTabBar, tabWillAppear tabBarItem: TTTabBarItem)

override func ttTabBar(tabBar: TTTabBar, tabDidAppear tabBarItem: TTTabBarItem)

//If the item has isButton = true, this method will be called
override func ttTabBar(tabBar: TTTabBar, buttonHasBeenClicked tabBarItem: TTTabBarItem)
```

