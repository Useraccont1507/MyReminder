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
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(modelData)
        }
    }
}
