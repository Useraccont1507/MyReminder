//
//  MyReminderApp.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

@main
struct MyReminderApp: App {
    
    private let builder = Builder()
    
    var body: some Scene {
        WindowGroup {
            builder.buildTabView()
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
