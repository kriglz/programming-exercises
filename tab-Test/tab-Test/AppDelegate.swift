//
//  AppDelegate.swift
//  tab-Test
//
//  Created by Kristina Gelzinyte on 3/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func newWindowAction(_ sender: NSButton) {
        
        let tabWindow = TabWindow()
        
        let tabWindowController = TabWindowController()

        tabWindowController.window = tabWindow
        
        tabWindowController.showWindow(nil)
    }
}

