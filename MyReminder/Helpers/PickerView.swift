//
//  PickerView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct ListPickerView: View {
  @Binding var selection: PickerModel
  
    var body: some View {
      Picker("Show", selection: $selection) {
        Text("Show important").tag(PickerModel.important)
        Text("Show normal").tag(PickerModel.normal)
        Text("Show all").tag(PickerModel.all)
      }
      .pickerStyle(.menu)
    }
}

struct AddTaskPriorityPickerView: View {
  @Binding var selection: TaskPriority
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Priority")
      Picker("Priority", selection: $selection) {
        Text("normal").tag(TaskPriority.normal)
        Text("important").tag(TaskPriority.important)
      }
      .pickerStyle(.segmented)
    }
  }
}

struct DatePickerView: View {
  @Binding var selection: Date
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Date")
        .padding(.leading, 4)
      DatePicker("", selection: $selection)
        .datePickerStyle(.wheel)
        .padding(.top, -20)
        .padding(.leading, -8)
    }
  }
}

#Preview {
  VStack {
    ListPickerView(selection: .constant(.all))
    AddTaskPriorityPickerView(selection: .constant(.normal))
    DatePickerView(selection: .constant(.now))
  }
}
