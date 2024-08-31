//
//  ModelData.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation

class ModelData: ObservableObject {
  @Published var tasks: [Task] = [
    Task(title: "Clean car", priority: .important,  isCompleted: false, date: Date.now),
    Task(title: "Clean home", priority: .normal, isCompleted: false, date: Date.now)
  ]
  
  func addTask(task: Task) {
    tasks.append(task)
  }
  
  func editTask(task: Task) {
    guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
      fatalError("cannot find index")
    }
    tasks[index] = task
  }
}
