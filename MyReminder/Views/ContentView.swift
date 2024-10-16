//
//  ContentView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI


struct ContentView: View {
  @State private var selection: Tab = .taskList
  
  enum Tab {
    case addTask
    case taskList
    case taskHistory
  }
  
  var body: some View {
    TabView(selection: $selection) {
      TaskList()
        .tag(Tab.taskList)
        .tabItem {
          Label("tasks".localized.localizedCapitalized, systemImage: "list.bullet")
        }
      AddTask()
        .tag(Tab.addTask)
        .tabItem {
          Label("new_task".localized, systemImage: "plus")
        }
      TaskHistory()
        .tag(Tab.taskHistory)
        .tabItem {
          Label("history".localized.localizedCapitalized, systemImage: "clock")
        }
    }
  }
}

#Preview {
    ContentView()
    .environmentObject(ModelData())
}
