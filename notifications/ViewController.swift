//
//  ViewController.swift
//  notifications
//
//  Created by Vyacheslav Horbach on 19/09/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import UIKit
import UserNotifications
import AirshipKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. Ask for permission
        UAirship.push().userPushNotificationsEnabled = true
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, err) in
            //enable or disable notification
            if err != nil {
                print(err.debugDescription)
            }
        }
        //2. Set up the notification
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: "Hello Wolrd", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Yo-yo-yo! Wassup?", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = NSNumber.init(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        //3. Deliver notification in 5 seconds
        let triger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest.init(identifier: "bla", content: content, trigger: triger)
        
        //4. Schedule the notification
        center.add(request) { (err) in
            if err != nil {
                print(err.debugDescription)
            }
        }
        
        ///
        print("scheduled")
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        //or with specific identifier
        center.removeDeliveredNotifications(withIdentifiers: ["bla"])
    }
}



