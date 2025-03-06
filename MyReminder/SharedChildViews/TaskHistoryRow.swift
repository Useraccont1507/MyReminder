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
        Spacer()
        task.dateTextView
      }
    }
}

#Preview {
  TaskHistoryRow(task: Task(title: "Test", priority: .normal, isCompleted: true, date: Date.now))
}
