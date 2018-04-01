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
    var isFileDroppable = false
    var droppedObjects: NSMutableArray = []
    var droppedFilePath: String? {
        didSet {
            droppedObjects.add(droppedFilePath)
        }
    }

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
            isFileDroppable = true
            return .copy
        } else {
            isFileDroppable = false
            return []
        }
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        if isFileDroppable {
            return .copy
        } else {
            return []
        }
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        sender.animatesToDestination = true
        
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        if let board = sender.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? NSArray, let imagePath = board[0] as? String {
            droppedFilePath = imagePath
            return true
        }
        return false
    }
    
    override func concludeDragOperation(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = CGColor.white
        
//        let iconButton = NSButton(frame: NSRect(x: 100, y: 65, width: 50, height: 100))
//        iconButton.isBordered = false
//        iconButton.imageScaling = .scaleProportionallyDown
//        iconButton.imagePosition = .imageAbove
//        let image = NSWorkspace.shared.icon(forFile: droppedObjects[0] as! String)
//        image.size = CGSize(width: 50, height: 50)
//        iconButton.image = image
//        iconButton.title = ((droppedObjects[0] as? NSString)?.lastPathComponent) ?? "picture"
//        iconButton.lineBreakMode = .byWordWrapping
//        iconButton.usesSingleLineMode = false
//        iconButton.imageHugsTitle = true
//
//        self.addSubview(iconButton)
        
        let imageView = NSImageView(frame: NSRect(x: 100, y: 65, width: 50, height: 50))
        imageView.imageScaling = .scaleProportionallyDown
        let image = NSWorkspace.shared.icon(forFile: droppedObjects[0] as! String)
        image.size = CGSize(width: 50, height: 50)
        imageView.image = image
        self.addSubview(imageView)
        
        let imageViewTitle = NSTextField(frame: NSRect(x: 75, y: 0, width: 100, height: 60))
        imageViewTitle.isBordered = false
        imageViewTitle.stringValue = ((droppedObjects[0] as? NSString)?.lastPathComponent) ?? "picture"
        imageViewTitle.maximumNumberOfLines = 0
        imageViewTitle.lineBreakMode = .byTruncatingHead
        imageViewTitle.alignment = .center
        self.addSubview(imageViewTitle)

        self.setNeedsDisplay(self.bounds)
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

