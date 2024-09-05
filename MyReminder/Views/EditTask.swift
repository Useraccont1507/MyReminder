//
//  EditTask.swift
//  MyReminder
//
//  Created by User on 31.08.2024.
//

import SwiftUI

struct EditTask: View {
  @Environment(\..dismiss) private var dismiss
  @EnvironmentObject var modelData: ModelData
  @State var transferedTask: Task
  @State private var alertErrorIsPresented = false
  @State private var alertConfirmIsPresented = false
  
  var body: some View {
    NavigationStack {
      List {
        VStack(alignment: .leading) {
          Text("Title")
          TextField("Add text here", text: $transferedTask.title)
            .textFieldStyle(.automatic)
            .onChange(of: transferedTask.title) { newValue in
              if newValue.count > 18 {
                transferedTask.title = String(newValue.prefix(18))
              }
            }
        }
        
        AddTaskPriorityPickerView(selection: $transferedTask.priority)
        DatePickerView(selection: $transferedTask.date)
      }
      .navigationTitle("Edit task")
      .toolbar {
        Button("Done") {
          if transferedTask.title.isEmpty {
            alertErrorIsPresented.toggle()
          } else {
            modelData.editTask(task: transferedTask)
            alertConfirmIsPresented.toggle()
          }
        }
        .bold()
      }
      .alert("Oops! Something went wrong", isPresented: $alertErrorIsPresented) {
        Button("OK") {
          alertErrorIsPresented.toggle()
        }
      } message: {
        Text("Task can't be saved without title")
      }
      .alert("Done!", isPresented: $alertConfirmIsPresented) {
        Button("OK") {
         dismiss()
        }
      } message: {
        Text("Task was successfully edited in list")
      }
    }
    .onAppear {
      
    }
  }
}

#Preview {
    EditTask(transferedTask: Task(title: "Clean", priority: .normal, isCompleted: false, date: Date.now))
}
