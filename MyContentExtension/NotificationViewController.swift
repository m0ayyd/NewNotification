//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by the Luckiest on 6/23/17.
//  Copyright © 2017 the Luckiest. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        if attachment.url.startAccessingSecurityScopedResource() {
            if let imageData = try? Data(contentsOf: attachment.url) {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "fistBump" {
            completion(.dismissAndForwardAction)
        }
        if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }

}
