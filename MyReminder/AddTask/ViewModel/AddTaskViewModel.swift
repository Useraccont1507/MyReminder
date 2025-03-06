//
//  AddTaskViewModel.swift
//  MyReminder
//
//  Created by Illia Verezei on 06.03.2025.
//

import Foundation

final class AddTaskViewModel: ObservableObject {
    private var notificationService: NotificationService? = nil
    
    init(notificationService: NotificationService?) {
        self.notificationService = notificationService
    }
    
    @Published var taskToAdd: Task = Task(title: "", priority: .normal, isCompleted: false, date: .now)
    
    func saveTask() {
        //Do smth storage
        notificationService?.checkPermissionAndCreateNotification(for: taskToAdd)
        print("Saved task \(taskToAdd)")
        eraseTaskForView()
    }
    
    private func eraseTaskForView() {
        taskToAdd = Task(title: "", priority: .normal, isCompleted: false, date: .now)
    }
}
