//
//  NotificationModel.swift
//  MyReminder
//
//  Created by User on 05.09.2024.
//

import Foundation
import UserNotifications

class LocalNotifications {
  static let shared = LocalNotifications()
  
  private let notificationCenter = UNUserNotificationCenter.current()
  
  func checkForPermission(task: Task) {
    notificationCenter.getNotificationSettings { settings in
      switch settings.authorizationStatus {
      case .authorized: self.addNotification(task: task)
      case .denied: self.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didAllow, error in
        if didAllow {
          self.addNotification(task: task)
        }
      }
      case .notDetermined: self.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didAllow, error in
        if didAllow {
          self.addNotification(task: task)
        }
      }
      default: return
      }
    }
  }
  
  func addNotification(task: Task) {
    let notification = Notification(title: task.title, body: task.body, date: task.date, identfier: task.notificationIdentifier)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponent, repeats: false)
    let request = UNNotificationRequest(identifier: notification.identfier, content: notification.content, trigger: trigger)
    
    removeNotification(task: task)
    
    notificationCenter.add(request) { error in
      if let error = error {
        //print("Error scheduling notification: \(error)")
      } else {
        //print("Notification for task '\(task.title)' scheduled!")
      }
    }
  }
  
  func removeNotification(task: Task) {
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [task.notificationIdentifier])
  }
  
  private init() {}
  
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
