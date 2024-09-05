import SwiftUI

struct ListPickerView: View {
  @Binding var selection: PickerModel
  
  var body: some View {
    Picker("", selection: $selection) {
      Text("All").tag(PickerModel.all)
      Text("Important").tag(PickerModel.important)
      Text("Normal").tag(PickerModel.normal)
    }
  }
}

struct AddTaskPriorityPickerView: View {
  @Binding var selection: TaskPriority
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Priority")
      Picker("", selection: $selection) {
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
        .padding(.leading, 8)
      DatePicker("", selection: $selection)
        .datePickerStyle(.wheel)
    }
  }
}
