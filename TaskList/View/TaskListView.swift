//
//  TaskList.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.editMode) private var editMode
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.pickerSelection {
                case .important:
                    ImportantPriorityTaskView(viewModel: viewModel)
                case .normal:
                    NormalPriorityTaskView(viewModel: viewModel)
                case .all:
                    AllPriorityTaskView(viewModel: viewModel)
                }
            }
            .navigationTitle("tasks".localized.localizedCapitalized)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ListPickerView(selection: $viewModel.pickerSelection)
                }
            })
        }
    }
}

struct ListPickerView: View {
    @Binding var selection: PickerModel
    
    var body: some View {
        Picker("", selection: $selection) {
            Text("all".localized.localizedCapitalized).tag(PickerModel.all)
            Text("important".localized.localizedCapitalized).tag(PickerModel.important)
            Text("normal".localized.localizedCapitalized).tag(PickerModel.normal)
        }
    }
}

#Preview {
    TaskListView(viewModel: TaskListViewModel())
}
