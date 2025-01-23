//
//  ViewModel.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var tasks: [Task] = [] {
    didSet {
      Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
    }
  }
  @Published var taskHistory: [Task] = [] {
    didSet {
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
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
    
    LocalNotifications.shared.checkForPermission(task: task)
    
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
    self.tasks.remove(at: index)
    self.taskHistory[index].isCompleted = true
    
    LocalNotifications.shared.removeNotification(task: task)
  }
  
  func deleteTask(indexSet: IndexSet) {
    LocalNotifications.shared.removeNotification(task: self.tasks[indexSet.first!])
    self.tasks.remove(atOffsets: indexSet)
  }
  
  func deleteAllHistory() {
    taskHistory.removeAll()
  }
}
