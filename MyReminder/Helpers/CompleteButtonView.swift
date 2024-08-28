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
      Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false) { timer in
        withAnimation(.easeInOut) {
          modelData.tasks.removeAll { task in
            task.id == taskToComplete.id
          }
        }
      }
      buttonName = "checkmark.circle.fill"
      isDisabled = true
    }, label: {
      Image(systemName: buttonName)
        .foregroundStyle(.blue)
    })
    .disabled(isDisabled)
    .opacity(1.0)
    .buttonStyle(BorderlessButtonStyle())
  }
}

#Preview {
  CompleteButtonView(taskToComplete: ModelData().tasks.first!)
    .environmentObject(ModelData())
}
