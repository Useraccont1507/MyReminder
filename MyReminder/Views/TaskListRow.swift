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
        Text(task.title)
          .font(.title2)
        
        Spacer()
        
        task.dateTextView
      }
    }
}

#Preview {
  TaskListRow(task: ModelData().tasks.first!)
}
