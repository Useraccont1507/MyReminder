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
        List {
            Section("normal".localized) {
                ForEach(viewModel.tasks) { task in
                    if task.priority == .normal {
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
    NormalPriorityTaskView(viewModel: TaskListViewModel())
}
