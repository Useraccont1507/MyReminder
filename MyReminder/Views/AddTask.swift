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
          Text("Title")
          TextField("Add text here", text: $newTask.title)
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
      .navigationTitle("New task")
      .toolbar {
        Button("Done") {
          if newTask.title.isEmpty {
            alertErrorIsPresented.toggle()
          } else {
            modelData.addTask(task: newTask)
            alertConfirmIsPresented.toggle()
          }
        }
        .bold()
      }
      .alert("Oops! Something went wrong", isPresented: $alertErrorIsPresented) {
        Button("OK") {
          dismiss()
        }
      } message: {
        Text("Task can't be added without title")
      }
      .alert("Done!", isPresented: $alertConfirmIsPresented) {
        Button("OK") {
          dismiss()
          
        }
      } message: {
        Text("Task was successfully added in list")
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
