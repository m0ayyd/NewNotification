//
//  ViewController.swift
//  NewNotifications
//
//  Created by the Luckiest on 6/23/17.
//  Copyright © 2017 the Luckiest. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notifications access granted")
            } else {
                print(error?.localizedDescription ?? "Error with NO Error")
            }
        }
        
    }
    
    @IBAction func notifyMeBtnTapped(_ sender: UIButton) {
        scheduleNotification(inSecondes: 5) { (success) in
            if success {
                print("Successfully sceduled notification")
            } else {
                print("Error sceduling notification")
            }
        }
    }
    
    func scheduleNotification(inSecondes: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        // Add an attachment
        let myImg = "rick_grimes"
        guard let imgURL = Bundle.main.url(forResource: myImg, withExtension: "gif") else {
            completion(false)
            return
        }
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imgURL, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "NewNotification"
        notif.subtitle = "These are great"
        notif.body = "The new notification in new iOS 10 are what I've always dreamed of!"
        notif.attachments.append(attachment)
        
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSecondes, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error with no error")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

