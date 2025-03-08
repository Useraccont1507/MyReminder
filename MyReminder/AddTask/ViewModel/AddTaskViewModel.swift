//
//  AddTaskViewModel.swift
//  MyReminder
//
//  Created by Illia Verezei on 06.03.2025.
//

import Foundation

final class AddTaskViewModel: ObservableObject {
    private var notificationService: NotificationService?
    private var storage: CoreDataService?
    
    init(storage: CoreDataService? = nil, notificationService: NotificationService? = nil) {
        self.storage = storage
        self.notificationService = notificationService
    }
    
    @Published var taskToAdd: Task = Task(title: "", priority: .normal, isCompleted: false, date: .now)
    
    func saveTask() {
        storage?.saveTask(taskToAdd)
        notificationService?.checkPermissionAndCreateNotification(for: taskToAdd)
        eraseTaskForView()
    }
    
    private func eraseTaskForView() {
        taskToAdd = Task(title: "", priority: .normal, isCompleted: false, date: .now)
    }
}
