//
//  TaskViewModel.swift
//  MyReminder
//
//  Created by Illia Verezei on 01.03.2025.
//

import Foundation

final class TaskListViewModel: ObservableObject {
    @Published var router: Router?
    private let storage: CoreDataService?
    private let notificationService: NotificationService?
    
    @Published var tasks: [Task] = []
    @Published var pickerSelection: PickerModel = .all
    
    init(router: Router? = nil, storage: CoreDataService? = nil, notificationService: NotificationService? = nil) {
        self.router = router
        self.storage = storage
        self.notificationService = notificationService
        self.updateTasks()
    }
    
    func updateTasks() {
        guard let storage = storage else { return }
        tasks = storage.loadTasks()
    }
    
    func editTask(task: Task) {
        guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
            fatalError("cannot find index")
        }
        router?.showEdit(index: index)
    }
    
    func makeTaskComplete(task: Task) {
        guard let storage = storage else { return }
        storage.deleteTask(task)
        updateTasks()
        notificationService?.removeNotification(task: task)
    }
    
    func deleteTask(indexSet: IndexSet) {
        guard let storage = storage else { return }
        indexSet.forEach { index in
            storage.deleteTask(tasks[index])
            notificationService?.removeNotification(task: tasks[index])
        }
        updateTasks()
    }
}
