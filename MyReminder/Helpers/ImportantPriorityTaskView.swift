//
//  ImportantPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct ImportantPriorityTaskView: View {
  var tasks: [Task]
  var body: some View {
    Section("important") {
      ForEach(tasks) { task in
        if task.priority == .important {
          NavigationLink {
            EditTask(transferedTask: task)
          } label: {
            TaskListRow(task: task)
          }
        }
      }
    }
  }
}

#Preview {
  NormalPriorityTaskView(tasks: [Task(title: "Test", priority: .important, isCompleted: false, date: Date())])
}
