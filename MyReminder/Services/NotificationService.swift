//
//  Notification.swift
//  MyReminder
//
//  Created by User on 05.09.2024.
//

import Foundation
import UserNotifications
import SwiftUI

final class NotificationService {
    private let notificationCenter = UNUserNotificationCenter.current()
    
    init(delegate: NotificationDelegate) {
        notificationCenter.delegate = delegate
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { isActivated, error in
            if !isActivated {
                // Show alert view
            }
        }
    }
    
    func checkPermissionAndCreateNotification(for task: Task) {
        notificationCenter.getNotificationSettings { [weak self] settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self?.requestAuthorization()
            case .denied:
                //Show alert view
                print()
            case .authorized:
                DispatchQueue.main.async {
                    self?.addNotification(task: task)
                }
            case .provisional:
                DispatchQueue.main.async {
                    self?.addNotification(task: task)
                }
            case .ephemeral:
                //Show alert view
                print()
            }
        }
    }
    
    private func addNotification(task: Task) {
        let notification = Notification(title: task.title, body: task.body, date: task.date, identfier: task.notificationIdentifier)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: notification.identfier, content: notification.content, trigger: trigger)
        
        removeNotification(task: task)
        
        notificationCenter.add(request) { error in
            if let error = error {
                //showAlert
            }
        }
    }
    
    func removeNotification(task: Task) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [task.notificationIdentifier])
    }
    
    struct Notification {
        let title: String
        let body: String?
        let date: Date
        let identfier: String
        
        var content: UNMutableNotificationContent {
            let content = UNMutableNotificationContent()
            
            if let body = body {
                content.title = self.title
                content.body = body
            } else {
                content.title = "MyReminder"
                content.body = self.title
            }
            
            content.sound = .default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            
            return content
        }
        
        var dateComponent: DateComponents {
            let calendar = Calendar.current
            var dateComponent = DateComponents()
            dateComponent.calendar = calendar
            dateComponent.timeZone = calendar.timeZone
            
            
            dateComponent.year = calendar.component(.year, from: date)
            dateComponent.month = calendar.component(.month, from: date)
            dateComponent.day = calendar.component(.day, from: date)
            dateComponent.hour = calendar.component(.hour, from: date)
            dateComponent.minute = calendar.component(.minute, from: date)
            
            return dateComponent
        }
    }
}

