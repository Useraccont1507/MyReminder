//
//  NormalPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct NormalPriorityTaskView: View {
  var tasks: [Task]
  var body: some View {
    Section("normal") {
      ForEach(tasks) { task in
        if task.priority == .normal {
          TaskListRow(task: task)
        }
      }
    }
  }
}

#Preview {
  NormalPriorityTaskView(tasks: [Task(title: "Test", priority: .normal, isCompleted: false, date: Date())])
}
