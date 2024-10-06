//
//  CompleteButtonView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct CompleteButtonView: View {
  @EnvironmentObject var modelData: ModelData
  @State private var buttonName = "checkmark.circle"
  @State private var isDisabled = false
  var taskToComplete: Task
  
  var body: some View {
    Button(action: {
      withAnimation(.easeInOut) {
        buttonName = "checkmark.circle.fill"
        isDisabled = true
      }
      Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false) { timer in
        modelData.makeTaskComplete(task: taskToComplete)
      }
    }, label: {
      Image(systemName: buttonName)
        .foregroundStyle(.accent)
    })
    .disabled(isDisabled)
    .opacity(1.0)
    .buttonStyle(BorderlessButtonStyle())
    .onAppear {
      if taskToComplete.isCompleted == true {
        buttonName = "checkmark.circle.fill"
        isDisabled = true
      }
    }
  }
}

#Preview {
  CompleteButtonView(taskToComplete: ModelData().tasks.first ?? Task(
    title: "Test",
    priority: .normal,
    isCompleted: false, date: Date())
  )
  .environmentObject(ModelData())
}
