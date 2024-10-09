//
//  ModelData.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation

class ModelData: ObservableObject {
  @Published var tasks: [Task] = []
  @Published var taskHistory: [Task] = []
  
  func addTask(task: Task) {
    tasks.append(task)
    taskHistory.append(task)
    
    DispatchQueue.global(qos: .userInitiated).async {
      Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
    }
  }
  
  func editTask(task: Task) {
    guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
      fatalError("cannot find index")
    }
    tasks[index] = task
    
    DispatchQueue.global(qos: .userInitiated).async {
      Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
    }
    
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
    
    DispatchQueue.global(qos: .userInitiated).async {
      Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
    }
    
    LocalNotifications.shared.removeNotification(task: task)
  }
  
  func deleteTask(indexSet: IndexSet) {
    LocalNotifications.shared.removeNotification(task: self.tasks[indexSet.first!])
    self.tasks.remove(atOffsets: indexSet)
    
    DispatchQueue.global(qos: .userInitiated).async {
      Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
    }
  }
  
  func deleteAllHistory() {
    taskHistory.removeAll()
    
    DispatchQueue.global(qos: .userInitiated).async {
      Storage.shared.save(tasks: self.taskHistory, forWhich: Storage.ArrayType.historyList)
    }
  }
}
