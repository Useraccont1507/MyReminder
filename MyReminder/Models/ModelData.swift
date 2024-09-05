//
//  ModelData.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation

class ModelData: ObservableObject {
  @Published var tasks: [Task] = [] {
    didSet {
      Storage.shared.save(tasks: tasks)
    }
  }
  
  @Published var taskHistory: [Task] = [] {
    didSet {
      Storage.shared.save(tasks: taskHistory)
    }
  }
  
  func addTask(task: Task) {
    tasks.append(task)
    taskHistory.append(task)
  }
  
  func editTask(task: Task) {
    guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
      fatalError("cannot find index")
    }
    tasks[index] = task
    guard let secondaryIndex = taskHistory.firstIndex(where: { $0.id == task.id}) else {
      taskHistory.append(task)
      return
    }
    taskHistory[secondaryIndex] = task
  }
  
  func makeTaskComplete(task: Task) {
    guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
      fatalError("cannot find index")
    }
    tasks.remove(at: index)
    taskHistory[index].isCompleted = true
    print(taskHistory)
  }
  
  func deleteTask(indexSet: IndexSet) {
    tasks.remove(atOffsets: indexSet)
  }
  
  func deleteAllHistory() {
    taskHistory.removeAll()
  }
}
