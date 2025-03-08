//
//  AddTask.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI


struct AddTaskView: View {
    @ObservedObject var viewModel: AddTaskViewModel
    @State private var alertErrorIsPresented = false
    @State private var alertConfirmIsPresented = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                TextFieldTitleView(text: $viewModel.taskToAdd.title)
                    .focused($isFocused)
                    .onTapGesture {
                        isFocused = false
                    }
                TextFieldBodyView(text: $viewModel.taskToAdd.body)
                    .focused($isFocused)
                    .onTapGesture {
                        isFocused = false
                    }
                AddTaskPriorityPickerView(selection: $viewModel.taskToAdd.priority)
                DatePickerView(selection: $viewModel.taskToAdd.date)
                    .onTapGesture {
                        isFocused = false
                    }
            }
            .navigationTitle("new_task".localized)
            .toolbar {
                Button("done".localized.localizedCapitalized) {
                    if viewModel.taskToAdd.title.isEmpty {
                        alertErrorIsPresented.toggle()
                    } else {
                        viewModel.saveTask()
                        alertConfirmIsPresented.toggle()
                    }
                }
                .bold()
            }
        }
        .alert("Oops_Something_went_wrong", isPresented: $alertErrorIsPresented) {
            Button("OK") {
                self.alertErrorIsPresented.toggle()
            }
        } message: {
            Text("Task_can't_be_added_without_title")
        }
        .alert("done".localized.localizedCapitalized + "!", isPresented: $alertConfirmIsPresented) {
            Button("OK") {
                self.alertConfirmIsPresented.toggle()
            }
        } message: {
            Text("Task_was_successfully_added_in_list")
        }
    }
}


#Preview {
    AddTaskView(viewModel: AddTaskViewModel(storage: nil, notificationService: nil))
}
