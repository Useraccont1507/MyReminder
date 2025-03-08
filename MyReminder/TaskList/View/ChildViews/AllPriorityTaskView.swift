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
        NavigationView {
            List {
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    let filteredTasks = viewModel.tasks.filter { $0.priority == priority }
                    if !filteredTasks.isEmpty {
                        Section(header: Text(priority.rawValue.localized)) {
                            ForEach(filteredTasks) { task in
                                TaskListRow(task: task, viewModel: viewModel)
                            }
                            .onDelete { indexSet in
                                viewModel.deleteTask(indexSet: indexSet)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AllPriorityTaskView(viewModel: TaskListViewModel())
}
