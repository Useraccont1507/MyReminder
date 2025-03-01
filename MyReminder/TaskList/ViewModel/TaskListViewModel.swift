//
//  TaskViewModel.swift
//  MyReminder
//
//  Created by Illia Verezei on 01.03.2025.
//

import Foundation

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Clean room", priority: .normal, isCompleted: false, date: Date.now + 30),
        Task(title: "Clean car", priority: .important, isCompleted: false, date: Date.now),
        Task(title: "Clean street", priority: .normal, isCompleted: false, date: Date.now + 100)
    ] {
      didSet {
        Storage.shared.save(tasks: self.tasks, forWhich: Storage.ArrayType.normalList)
      }
    }

    @Published var pickerSelection: PickerModel = .all
    
    func editTask(task: Task) {
      guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
        fatalError("cannot find index")
      }
      tasks[index] = task
      
        //TODO: - repair
      LocalNotifications.shared.checkForPermission(task: task)
    }
    
    func makeTaskComplete(task: Task) {
      guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
        fatalError("cannot find index")
      }
      self.tasks.remove(at: index)
        //TODO: - repair
      //self.taskHistory[index].isCompleted = true
        //TODO: - repair
      LocalNotifications.shared.removeNotification(task: task)
    }
    
    func deleteTask(indexSet: IndexSet) {
      LocalNotifications.shared.removeNotification(task: self.tasks[indexSet.first!])
      self.tasks.remove(atOffsets: indexSet)
    }
}
