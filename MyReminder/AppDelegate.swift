//
//  AppDelegate.swift
//  MyReminder
//
//  Created by User on 07.09.2024.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Set the delegate for the notification center
    UNUserNotificationCenter.current().delegate = self
    requestNotificationAuthorization()
    return true
  }
  
  // Request notification permission from the user
  func requestNotificationAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if granted {
        print("Permission granted")
      } else {
        print("Permission denied")
      }
    }
  }
  
  // Display the banner while the app is in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound])  // Show banner and play sound even if app is in foreground
  }
}
