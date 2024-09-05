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
        .tag("List")
        .tabItem {
          Label("Tasks", systemImage: "list.bullet")
        }
      AddTask()
        .tag("Add new")
        .tabItem {
          Label("New task", systemImage: "plus")
        }
      TaskHistory()
        .tag("History")
        .tabItem {
          Label("History", systemImage: "clock")
        }
    }
  }
}

#Preview {
    ContentView()
    .environmentObject(ModelData())
}
