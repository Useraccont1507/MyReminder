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
  @State private var newTask = Task(title: "", priority: .normal, isCompleted: false, date: Date.now)
  @State private var alertErrorIsPresented = false
  @State private var alertConfirmIsPresented = false
  
  var body: some View {
    NavigationStack {
      List {
        VStack(alignment: .leading) {
          Text("title".localized.localizedCapitalized)
          TextField("add_text_here".localized, text: $newTask.title)
            .textFieldStyle(.automatic)
            .onChange(of: newTask.title) { newValue in
              if newValue.count > 18 {
                newTask.title = String(newValue.prefix(18))
              }
            }
        }
        AddTaskPriorityPickerView(selection: $newTask.priority)
        DatePickerView(selection: $newTask.date)
      }
      .navigationTitle("new".localized.capitalized(with: .current) + " " + "tasks".localized)
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
