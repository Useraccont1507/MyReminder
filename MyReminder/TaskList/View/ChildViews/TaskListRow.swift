//
//  TaskListRow.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskListRow: View {
    var task: Task
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        HStack {
            CompleteButtonView(viewModel: viewModel, taskToComplete: task)
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
            
            Spacer(minLength: 30)
            
            task.dateTextView
        }
    }
}

struct CompleteButtonView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var buttonName = "checkmark.circle"
    @State private var isDisabled = false
    var taskToComplete: Task
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                buttonName = "checkmark.circle.fill"
                isDisabled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeIn) {
                    viewModel.makeTaskComplete(task: taskToComplete)
                }
            }
        }, label: {
            Image(systemName: buttonName)
                .foregroundStyle(.accent)
        })
        .disabled(isDisabled)
        .opacity(1.0)
        .buttonStyle(BorderlessButtonStyle())
        .onAppear {
            if taskToComplete.isCompleted == true {
                buttonName = "checkmark.circle.fill"
                isDisabled = true
            }
        }
    }
}

#Preview {
    TaskListRow(task: Task(
                    title: "Test title",
                    body: "Test body",
                    priority: .normal,
                    isCompleted: false, date: Date()
                ),
                viewModel: TaskListViewModel())
}
