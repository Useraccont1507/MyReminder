//
//  NormalPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct NormalPriorityTaskView: View {
  @EnvironmentObject var modelData: ModelData
  
  var tasks: [Task]
  var body: some View {
    Section("normal") {
      ForEach(tasks) { task in
        if task.priority == .normal {
          NavigationLink {
            EditTask(transferedTask: task)
          } label: {
            TaskListRow(task: task)
          }
        }
      }
      .onDelete(perform: { indexSet in
        modelData.deleteTask(indexSet: indexSet)
      })
    }
  }
}

#Preview {
  NormalPriorityTaskView(tasks: [Task(title: "Test", priority: .normal, isCompleted: false, date: Date())])
}
