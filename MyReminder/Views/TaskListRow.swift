//
//  TaskListRow.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskListRow: View {
  var task: Task
  
    var body: some View {
      HStack {
        CompleteButtonView(taskToComplete: task)
        VStack(alignment: .leading) {
          Text(task.title)
            .font(.body)
          if let body = task.body {
            Text(body)
              .lineLimit(2)
              .font(.footnote)
              .foregroundStyle(.secondary)
          }
        }
        
        Spacer(minLength: 30)
        
        task.dateTextView
      }
    }
}

#Preview {
  TaskListRow(task: ModelData().tasks.first ?? Task(
    title: "Test",
    body: "Test body :)bgfbfgbfgbfgbfgbfgbfbgfgbfgbfgbfgbfgbfgbfgbfgbfgb",
    priority: .normal,
    isCompleted: false, date: Date())
  )
}
