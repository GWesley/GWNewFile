//
//  FinderSync.swift
//  FinderExtention
//
//  Created by zhangzhiyong-pd@360.cn on 16/12/21.
//  Copyright © 2016年 zhangzhiyong-pd@360.cn. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    let fileTypes = [
        "New Text": ".txt",
        "New Markdown": ".md",
        "New JS File": ".js",
        "New Python File": ".py",
        "New Html File": ".html"
    ]
    
    var myFolderURL = URL(fileURLWithPath: "/Users")
    
    override init() {
        super.init()
        NSLog("===> FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
    }
    
    // MARK: - Menu and toolbar item support
    
    override var toolbarItemName: String {
        return "NewFile"
    }
    
    override var toolbarItemToolTip: String {
        return "NewFile: Click the toolbar item for a menu."
    }
    
    override var toolbarItemImage: NSImage {
        return NSImage(named: NSImage.addTemplateName)!
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension.
        let menu = NSMenu(title: "")
        for (menuTitle, _) in fileTypes {
            menu.addItem(withTitle: menuTitle, action: #selector(addFile(_:)), keyEquivalent: "")
        }
        return menu
    }
    
    func generateRandomStringWithLength(_ length:Int) -> String {
        
        let randomString:NSMutableString = NSMutableString(capacity: length)
        
        let letters:NSMutableString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var i: Int = 0
        
        while i < length {
            
            let randomIndex:Int = Int(arc4random_uniform(UInt32(letters.length)))
            randomString.append("\(Character( UnicodeScalar( letters.character(at: randomIndex))!))")
            i += 1
        }
        
        return String(randomString)
    }
    
    @IBAction func addFile(_ item: NSMenuItem) {
        if let ext = fileTypes[item.title], let target = FIFinderSyncController.default().targetedURL() {
            let path = target.path + "/" + generateRandomStringWithLength(4) + ext
            do {
                try "".write(toFile: path, atomically: false, encoding: .utf8)
                NSWorkspace().selectFile(path, inFileViewerRootedAtPath: "")
            } catch  {
                print("add file to \(path) failed : \(error.localizedDescription)")
            }
        }
    }
}

