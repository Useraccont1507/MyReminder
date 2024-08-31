//
//  AllPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct AllPriorityTaskView: View {
  var tasks: [Task]
  var body: some View {
    ForEach(TaskPriority.allCases){ priority in
      Section(priority.rawValue) {
        ForEach(tasks) { task in
          if task.priority == priority {
            NavigationLink(destination: EditTask(transferedTask: task)) {
              TaskListRow(task: task)
            }
          }
        }
      }
    }
  }
}

#Preview {
  AllPriorityTaskView(tasks: [Task(title: "Test", priority: .normal, isCompleted: false, date: Date())])
}
