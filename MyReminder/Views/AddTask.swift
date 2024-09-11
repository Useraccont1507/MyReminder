//
//  AddTask.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct AddTask: View {
  @Environment(\..dismiss) var dismiss
  @EnvironmentObject var modelData: ModelData
  @State private var newTask = Task(title: "", body: nil, priority: .normal, isCompleted: false, date: Date.now)
  @State private var alertErrorIsPresented = false
  @State private var alertConfirmIsPresented = false
  @FocusState private var isFocused: Bool
  
  var body: some View {
    NavigationStack {
      List {
        TextFieldTitleView(text: $newTask.title)
          .focused($isFocused)
          .onTapGesture {
            isFocused = false
          }
        TextFieldBodyView(text: $newTask.body)
          .focused($isFocused)
          .onTapGesture {
            isFocused = false
          }
        AddTaskPriorityPickerView(selection: $newTask.priority)
        DatePickerView(selection: $newTask.date)
          .onTapGesture {
            isFocused = false
          }
      }
      .navigationTitle("new_task".localized)
      .toolbar {
        Button("done".localized.localizedCapitalized) {
          if newTask.title.isEmpty {
            alertErrorIsPresented.toggle()
          } else {
            modelData.addTask(task: newTask)
            alertConfirmIsPresented.toggle()
          }
        }
        .bold()
      }
      .alert("Oops_Something_went_wrong", isPresented: $alertErrorIsPresented) {
        Button("OK") {
          dismiss()
        }
      } message: {
        Text("Task_can't_be_added_without_title")
      }
      .alert("done".localized.localizedCapitalized + "!", isPresented: $alertConfirmIsPresented) {
        Button("OK") {
          dismiss()
          
        }
      } message: {
        Text("Task_was_successfully_added_in_list")
      }
    }
    .onAppear {
      newTask = Task(title: "", priority: .normal, isCompleted: false, date: Date.now)
    }
  }
}

#Preview {
  AddTask()
    .environmentObject(ModelData())
}
