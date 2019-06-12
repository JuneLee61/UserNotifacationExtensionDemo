//
//  NotificationViewController.swift
//  NotificationExtension
//
//  Created by JuneLee on 2019/3/28.
//  Copyright © 2019 JuneLee. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.titleLabel.text = notification.request.content.title
        self.subLabel.text = notification.request.content.subtitle
        self.bodyLabel?.text = notification.request.content.body
    }

}
