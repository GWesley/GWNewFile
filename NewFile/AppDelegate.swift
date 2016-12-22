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
        let callback: CFNotificationCallback = { center, observer, name, object, userInfo in
            if let info = userInfo {
                if let dict = info as? [String: String] {
                    if let path = dict["path"] {
                        do {
                            try "".write(toFile: path, atomically: false, encoding: .utf8)
                        } catch  {
                            print("add file to \(path) failed : \(error.localizedDescription)")
                        }
                        
                    }
                }
            }
        }
        
        let notifiId: CFString = "gw.newfile.add" as CFString
        CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
                                        nil,
                                        callback,
                                        notifiId,
                                        nil,
                        .deliverImmediately);
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func postTest() {
        let notifiId: CFString = "gw.newfile.add" as CFString
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(),
                                             CFNotificationName(rawValue: notifiId),
                                             nil,
                                             ["path":"asdjfhak"] as CFDictionary,
                                             true);
    }
}

