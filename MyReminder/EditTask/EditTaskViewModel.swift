//
//  EditTaskViewModel.swift
//  MyReminder
//
//  Created by Illia Verezei on 08.03.2025.
//

import Foundation

final class EditTaskViewModel: ObservableObject {
    var router: Router?
    var storage: CoreDataService?
    var notificationService: NotificationService?
    @Published var taskToEdit: Task = Task(title: "Test", priority: .normal, isCompleted: false, date: .now)
    @Published var alertErrorIsPresented = false
    @Published var alertConfirmIsPresented = false
    
    init(indexOftask: Int, router: Router? = nil, storage: CoreDataService? = nil, notificationService: NotificationService? = nil) {
        self.router = router
        self.storage = storage
        self.notificationService = notificationService
        self.taskToEdit = getTaskToEdit(index: indexOftask)
    }
    
    private func getTaskToEdit(index: Int) -> Task {
        guard let storage = storage else {
            let mockTask = Task(title: "Test", priority: .normal, isCompleted: false, date: .now)
            return mockTask
        }
        return storage.loadTasks()[index]
    }
    
    func checkTitle() {
        if taskToEdit.title.isEmpty {
            alertErrorIsPresented.toggle()
            router?.back()
        } else {
            submitChanges()
            alertConfirmIsPresented.toggle()
        }
    }
    
    private func submitChanges() {
        storage?.editTask(taskToEdit)
    }
    
    func moveBack() {
        router?.back()
    }
}
