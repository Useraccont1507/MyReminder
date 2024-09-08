//
//  TaskList.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskList: View {
  @Environment(\.editMode) private var editMode
  @EnvironmentObject var modelData: ModelData
  @State private var pickerSelection: PickerModel = .all
  
  var body: some View {
    NavigationStack {
      List {
        switch pickerSelection {
        case .important:
          ImportantPriorityTaskView(tasks: modelData.tasks)
        case .normal:
          NormalPriorityTaskView(tasks: modelData.tasks)
        case .all:
          AllPriorityTaskView(tasks: modelData.tasks)
        }
      }
      .navigationTitle("tasks".localized.localizedCapitalized)
      .toolbar(content: {
        ToolbarItem(placement: .topBarLeading) {
          EditButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
          ListPickerView(selection: $pickerSelection)
        }
      })
    }
  }
}

#Preview {
  TaskList()
    .environmentObject(ModelData())
}
