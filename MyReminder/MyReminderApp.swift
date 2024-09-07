//
//  MyReminderApp.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

@main
struct MyReminderApp: App {
  @StateObject var modelData = ModelData()
  // Register AppDelegate
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(modelData)
        .onAppear {
          modelData.tasks = Storage.shared.load()
          modelData.taskHistory = Storage.shared.load()
        }
    }
  }
}
