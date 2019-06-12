//
//  ViewController.swift
//  UserNotifacationDemo
//
//  Created by JuneLee on 2019/3/28.
//  Copyright © 2019 JuneLee. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let sendButton = UIButton(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50))
        sendButton.setTitle("发送通知", for: .normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(sendButton)
        
        sendButton.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
        
    }


    
    @objc func sendNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { (settings) in
            print("当前授权状态：\(settings.authorizationStatus)")
            
            let notification = UNMutableNotificationContent()
            notification.title = "定时推送通知"
            notification.subtitle = "哈哈哈"
            notification.body = "欢迎来到JuneLee！"
            notification.badge = 1
            notification.sound = UNNotificationSound.default

            let timerTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            notification.categoryIdentifier = "category"
            
            let request = UNNotificationRequest(identifier: "locaNotification", content: notification, trigger: timerTrigger)
            
            center.add(request, withCompletionHandler: { (error) in
                if (error != nil) {
                    print("通知发送成功")
                }else {
                    print("错误：\(String(describing: error))")
                }
            })
  
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        
        center.removeDeliveredNotifications(withIdentifiers: ["locaNotification"])
    }
}

