//
//  TabWindow.swift
//  tab-Test
//
//  Created by Kristina Gelzinyte on 3/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class TabWindow: NSWindow {

    convenience init() {
        self.init(contentRect: NSRect(x: 100, y: 100, width: 600, height: 200),
                  styleMask: NSWindow.StyleMask.titled,
                  backing: BackingStoreType.buffered,
                  defer: true)
        
        self.makeKeyAndOrderFront(nil)
        
        self.title = "Test"
        
//        self.showsResizeIndicator = true
        
        self.styleMask = [.titled, .closable, .unifiedTitleAndToolbar]
        
//        let titleBarAccess = NSTitlebarAccessoryViewController()
//
//        titleBarAccess.isHidden = false
//
//        self.addTitlebarAccessoryViewController(titleBarAccess)
    }
    
}
