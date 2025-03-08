//
//  EditTask.swift
//  MyReminder
//
//  Created by User on 31.08.2024.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditTaskViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
            NavigationView {
                List {
                    TextFieldTitleView(text: $viewModel.taskToEdit.title)
                        .focused($isFocused)
                        .onTapGesture {
                            isFocused = false
                        }
                    TextFieldBodyView(text: $viewModel.taskToEdit.body)
                        .focused($isFocused)
                        .onTapGesture {
                            isFocused = false
                        }
                    AddTaskPriorityPickerView(selection: $viewModel.taskToEdit.priority)
                    DatePickerView(selection: $viewModel.taskToEdit.date)
                        .onTapGesture {
                            isFocused = false
                        }
                }
                .navigationTitle("edit_task".localized)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button(action: {
                            viewModel.moveBack()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("back".localized.localizedCapitalized)
                            }
                        }
                    })
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("done".localized.localizedCapitalized) {
                            viewModel.checkTitle()
                        }
                        .bold()
                    }
                }
                .alert("Oops_Something_went_wrong", isPresented: $viewModel.alertErrorIsPresented) {
                    Button("OK") {
                        viewModel.alertErrorIsPresented.toggle()
                    }
                } message: {
                    Text("Task_can't_be_added_without_title")
                }
                .alert("done".localized.localizedCapitalized + "!", isPresented: $viewModel.alertConfirmIsPresented) {
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("Task_was_successfully_edited")
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
}

#Preview {
    EditTaskView(viewModel: EditTaskViewModel(indexOftask: 0))
}
