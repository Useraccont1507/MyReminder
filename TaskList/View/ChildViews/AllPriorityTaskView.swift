//
//  AllPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct AllPriorityTaskView: View {
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        List {
            ForEach(TaskPriority.allCases){ priority in
                Section(priority.rawValue.localized) {
                    ForEach(viewModel.tasks) { task in
                        if task.priority == priority {
                            TaskListRow(task: task, viewModel: viewModel)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteTask(indexSet: indexSet)
                    })
                }
            }
        }
    }
}

#Preview {
    AllPriorityTaskView(viewModel: TaskListViewModel())
}
