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
        List {
            Section("important".localized) {
                ForEach(viewModel.tasks) { task in
                    if task.priority == .important {
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

#Preview {
    ImportantPriorityTaskView(viewModel: TaskListViewModel())
}
