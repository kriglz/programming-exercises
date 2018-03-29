//
//  TabWindow.swift
//  tab-Test
//
//  Created by Kristina Gelzinyte on 3/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class TabWindow: NSWindow, NSToolbarDelegate {
    
    var toolbarTabsArray = [["title": "First a",
                             "icon":"second",
                             "class": "First",
                             "identifier": "First"],
                            ["title": "Second b",
                             "icon": "second",
                             "class": "Second",
                             "identifier":"Second"],
                            ["title": "Third c",
                             "icon": "third",
                             "class": "Third",
                             "identifier": "Third"]]
    
    var toolbarTabsIdentifierArray: [NSToolbarItem.Identifier] = []
    
//    var currentView = ""
//    var currentViewController = NSViewController()
    
    convenience init() {
        self.init(contentRect: NSRect(x: 100, y: 100, width: 600, height: 600),
                  styleMask: NSWindow.StyleMask.titled,
                  backing: BackingStoreType.buffered,
                  defer: true)
        
        self.makeKeyAndOrderFront(nil)
        self.title = "Test"
        self.styleMask = [.titled, .closable, .miniaturizable, .resizable, .unifiedTitleAndToolbar]

        for dictionary in toolbarTabsArray {
            guard let identifier = dictionary["identifier"] else { return }
            toolbarTabsIdentifierArray.append(NSToolbarItem.Identifier.init(identifier))
        }
        
        let toolbarz = NSToolbar(identifier: NSToolbar.Identifier(rawValue: "TestToolbar"))
        
//        var index = 0
//        for itemId in toolbarTabsIdentifierArray {
//
//            self.toolbar?.insertItem(withItemIdentifier: itemId, at: index)
//            index += 1
//        }
//
        toolbarz.isVisible = true
        toolbarz.allowsUserCustomization = true
        toolbarz.delegate = self
        
        self.toolbar = toolbarz
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var infoDictionary = [String: String]()
        
        for dictionary in toolbarTabsArray {
            if dictionary["identifier"] == itemIdentifier.rawValue {
                infoDictionary = dictionary
                break
            }
        }
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
//        toolbarItem.label = infoDictionary["title"]!
        toolbarItem.image = NSImage(named: NSImage.Name(rawValue: (infoDictionary["icon"]?.description)!))
        toolbarItem.target = self
//        toolbarItem.action = #selector(viewSelected)
        
        return toolbarItem
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarTabsIdentifierArray
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarTabsIdentifierArray
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarTabsIdentifierArray
    }
    
//    @objc func viewSelected(sender: NSToolbarItem) {
//        self.loadViewWithIdentifier(viewTabIdentifier: sender.itemIdentifier.rawValue, withAnimation: true)
//    }
//
//    func loadViewWithIdentifier(viewTabIdentifier: String, withAnimation shouldAnimate:Bool) {
//        guard currentView == viewTabIdentifier else { return }
//
//        currentView = viewTabIdentifier
//
//        var infoDictionary = [String: String]()
//
//        for dictionary in toolbarTabsArray {
//            if dictionary["identifier"] == viewTabIdentifier {
//                infoDictionary = dictionary
//                break
//            }
//        }
//
//        let className = infoDictionary["class"]!
//
//        switch className {
//        case "First":
//            currentViewController = First(nibName: NSNib.Name(rawValue: "First"), bundle: nil)
//
//        case "Second":
//            currentViewController = Second(nibName: NSNib.Name(rawValue: "Second"), bundle: nil)
//
//        case "Third":
//            currentViewController = Third(nibName: NSNib.Name(rawValue: "Third"), bundle: nil)
//
//        default:
//            break
//        }
//
//        let newView = currentViewController.view
//        self.contentView = newView
//
//        let windowRect = self.frame
//        let currentViewRect = newView.frame
//
//        let yPos = windowRect.origin.y + (windowRect.size.height - currentViewRect.size.height)
//        let newFrame = NSRect(x: windowRect.origin.x, y: yPos, width: currentViewRect.size.width, height: currentViewRect.size.height)
//
//        self.setFrame(newFrame, display: true, animate: true)
//    }
}
