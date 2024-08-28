//
//  TaskList.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskList: View {
  @EnvironmentObject var modelData: ModelData
  
    var body: some View {
      NavigationStack {
        List {
          ForEach(modelData.tasks) { task in
            TaskListRow(task: task)
          }
        }
      }
    }
}

#Preview {
    TaskList()
    .environmentObject(ModelData())
}
