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
  @FocusState private var isFocused: Bool
  
  var body: some View {
    NavigationStack {
      List {
        VStack(alignment: .leading) {
          Text("title".localized.localizedCapitalized)
          TextField("add_text_here".localized, text: $transferedTask.title)
            .textFieldStyle(.automatic)
            .focused($isFocused)
            .onChange(of: transferedTask.title) { newValue in
              if newValue.count > 18 {
                transferedTask.title = String(newValue.prefix(18))
              }
            }
        }
        
        AddTaskPriorityPickerView(selection: $transferedTask.priority)
        DatePickerView(selection: $transferedTask.date)
          .onTapGesture {
            isFocused = false
          }
      }
      .navigationTitle("edit".localized.localizedCapitalized)
      .toolbar {
        Button("done".localized.localizedCapitalized) {
          if transferedTask.title.isEmpty {
            alertErrorIsPresented.toggle()
          } else {
            modelData.editTask(task: transferedTask)
            alertConfirmIsPresented.toggle()
          }
        }
        .bold()
      }
      .alert("Oops_Something_went_wrong", isPresented: $alertErrorIsPresented) {
        Button("OK") {
          alertErrorIsPresented.toggle()
        }
      } message: {
        Text("Task_can't_be_added_without_title")
      }
      .alert("done".localized.localizedCapitalized + "!", isPresented: $alertConfirmIsPresented) {
        Button("OK") {
         dismiss()
        }
      } message: {
        Text("Task_was_successfully_edited")
      }
    }
    .onAppear {
      
    }
  }
}

#Preview {
    EditTask(transferedTask: Task(title: "Clean", priority: .normal, isCompleted: false, date: Date.now))
}
