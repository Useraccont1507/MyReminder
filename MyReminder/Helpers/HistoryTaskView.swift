//
//  HistoryTaskView.swift
//  MyReminder
//
//  Created by User on 01.09.2024.
//

import SwiftUI

struct HistoryTaskView: View {
  var listTitle: String
  var tasks: [Task]
  var body: some View {
    List {
      ForEach(TaskPriority.allCases){ priority in
        Section(priority.rawValue) {
          ForEach(tasks) { task in
            if task.priority == priority {
              TaskHistoryRow(task: task)
            }
          }
        }
      }
    }
    .navigationTitle(listTitle)
  }
}

#Preview {
  HistoryTaskView(listTitle: "Test", tasks: [Task(title: "Test", priority: .normal, isCompleted: false, date: Date())])
}
