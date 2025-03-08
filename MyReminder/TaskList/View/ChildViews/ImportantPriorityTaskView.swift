//
//  ImportantPriorityTaskView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct ImportantPriorityTaskView: View {
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        let importantTasks = viewModel.tasks.filter { $0.priority == .important }
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
    ImportantPriorityTaskView(viewModel: TaskListViewModel(storage: nil, notificationService: nil))
}
