//
//  MyReminderApp.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

@main
struct MyReminderApp: App {
  @StateObject var viewModel = ViewModel()
  // Register AppDelegate
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
//      ContentView()
//        .environmentObject(viewModel)
//        .onAppear {
//          viewModel.tasks = Storage.shared.load(forWhich: Storage.ArrayType.normalList)
//          viewModel.taskHistory = Storage.shared.load(forWhich: Storage.ArrayType.historyList)
//        }
        TaskListView(viewModel: TaskListViewModel())
    }
  }
}
