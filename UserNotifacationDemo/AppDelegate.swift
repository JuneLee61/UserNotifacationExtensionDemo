//
//  AppDelegate.swift
//  UserNotifacationDemo
//
//  Created by JuneLee on 2019/3/28.
//  Copyright © 2019 JuneLee. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import WebKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        requestAuth()
        
        return true
    }

    
    func requestAuth() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        
        let textAction = UNTextInputNotificationAction(identifier: "TextInputAction", title: "请输入文本", options: UNNotificationActionOptions.authenticationRequired)
        let action1 = UNNotificationAction(identifier: "foreGroud", title: "打开", options: UNNotificationActionOptions.foreground)
        let action2 = UNNotificationAction(identifier: "backGroud", title: "关闭  ", options: UNNotificationActionOptions.destructive)

        let category = UNNotificationCategory(identifier: "category", actions: [textAction,action1,action2], intentIdentifiers: [], options: UNNotificationCategoryOptions.customDismissAction)

        
        center.setNotificationCategories(NSSet(objects: category) as! Set<UNNotificationCategory>)
        
        center.requestAuthorization(options: UNAuthorizationOptions(rawValue: UNAuthorizationOptions.badge.rawValue|UNAuthorizationOptions.alert.rawValue|UNAuthorizationOptions.sound.rawValue)) { (granted, error) in
            if granted {
                print("授权成功")
            }
        }
    }
    
    //app在前台收到通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("----------app处理前台接收到了通知----------")
        
        alertView(message: "app处理前台接收到了通知")
        
//        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))
//        webview.center = (self.window?.center)!
//        webview.load(URLRequest(url: URL.init(fileURLWithPath: "http://www.itheima.com")))
//        self.window?.addSubview(webview)
//
//        webview.alpha = 0
//        UIView.animate(withDuration: 1) {
//            webview.alpha = 1
//        }
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    //按钮的点击事件
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier.elementsEqual("TextInputAction") {
            let textAction:UNTextInputNotificationResponse = response as! UNTextInputNotificationResponse
            print("输入的内容为：\(textAction.userText)")
            alertView(message: "输入的内容为：\(textAction.userText)")

        }
        print("\(response.actionIdentifier)")
        alertView(message: "aaaaaaaa\(NSDate.init())\(response.actionIdentifier)")
        completionHandler()
    }

    
    func alertView(message:String) {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "确定", style: .default) { (action) in
            
        }
        alert.addAction(action)
        self.window?.rootViewController?.showDetailViewController(alert, sender: nil)
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

