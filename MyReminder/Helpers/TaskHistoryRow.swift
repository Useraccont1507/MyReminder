//
//  TaskHistoryRow.swift
//  MyReminder
//
//  Created by User on 01.09.2024.
//

import SwiftUI

struct TaskHistoryRow: View {
  var task: Task
  
    var body: some View {
      HStack {
        Text(task.title)
          .font(.body)
        Spacer()
        task.dateTextView
      }
    }
}

#Preview {
  TaskHistoryRow(task: Task(title: "Test", priority: .normal, isCompleted: true, date: Date.now))
}
