//
//  NormalPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct NormalPriorityTaskView: View {
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        let importantTasks = viewModel.tasks.filter { $0.priority == .normal }
        List {
            if !importantTasks.isEmpty {
                Section(header: Text("important".localized)) {
                    ForEach(importantTasks) { task in
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

#Preview {
    NormalPriorityTaskView(viewModel: TaskListViewModel(storage: nil, notificationService: nil))
}
