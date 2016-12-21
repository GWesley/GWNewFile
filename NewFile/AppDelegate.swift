//
//  AppDelegate.swift
//  NewFile
//
//  Created by zhangzhiyong-pd@360.cn on 16/12/21.
//  Copyright © 2016年 zhangzhiyong-pd@360.cn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func newFileWithPath(info:[AnyHashable : Any]?) {
        if let userInfo = info {
            if let path = userInfo["path"] {
                NSLog("\(path)")
            }
            
        }
    }

}

