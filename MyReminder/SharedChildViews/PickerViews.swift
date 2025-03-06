import SwiftUI

struct AddTaskPriorityPickerView: View {
  @Binding var selection: TaskPriority
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("priority".localized.localizedCapitalized)
      Picker("", selection: $selection) {
        Text("normal".localized).tag(TaskPriority.normal)
        Text("important".localized).tag(TaskPriority.important)
      }
      .pickerStyle(.segmented)
    }
  }
}

struct DatePickerView: View {
  @Binding var selection: Date
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("date".localized.localizedCapitalized)
        .padding(.leading, 8)
      DatePicker("", selection: $selection)
        .datePickerStyle(.wheel)
    }
  }
}
