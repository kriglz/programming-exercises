//
//  AppDelegate.swift
//  drag-and-drop
//
//  Created by Kristina Gelzinyte on 3/30/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSDraggingDestination {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var dropView: MyView!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
}

class MyView: NSView {

    let fileTypes = ["jpg", "jpeg", "bmp", "png", "gif"]
    var fileTypeIsOk = false
    var droppedFilePath: String?
    let NSFilenamesPboardType = NSPasteboard.PasteboardType("NSFilenamesPboardType")
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        self.layer?.backgroundColor = CGColor.white
        
        // Declare and register an array of accepted types
        registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeFileURL as String),
                                 NSPasteboard.PasteboardType(kUTTypeItem as String)])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(drag: sender) {
            self.layer?.backgroundColor = CGColor.black

            fileTypeIsOk = true
            return .copy
        } else {
            fileTypeIsOk = false
            return []
        }
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        if fileTypeIsOk {
            return .copy
        } else {
            return []
        }
    }
    
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        if let board = sender.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? NSArray, let imagePath = board[0] as? String {
            // THIS IS WERE YOU GET THE PATH FOR THE DROPPED FILE
            droppedFilePath = imagePath
            return true
        }
        return false
    }
    
    override func concludeDragOperation(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = CGColor.white
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = CGColor.white
    }
    
    func checkExtension(drag: NSDraggingInfo) -> Bool {
        if let board = drag.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? NSArray, let path = board[0] as? String {
            let url = NSURL(fileURLWithPath: path)
            if let fileExtension = url.pathExtension?.lowercased() {
                return fileTypes.contains(fileExtension)
            }
        }
        return false
    }
}

