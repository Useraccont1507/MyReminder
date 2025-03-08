//
//  ViewBuilder.swift
//  MyReminder
//
//  Created by Illia Verezei on 08.03.2025.
//

import SwiftUI

final class Builder {
    private let router = Router()
    private let storage = CoreDataService()
    private let notificationService = NotificationService(delegate: NotificationDelegate())
    
    init() {
        notificationService.requestAuthorization()
    }
    
    func buildTabView() -> some View {
        MainTabView(router: router, builder: self)
    }
    
    func buildTaskListRouterFlow() -> some View {
        TaskListRouterFlow(router: router, builder: self)
    }
    
    func buildTaskListView() -> some View {
        let viewModel = TaskListViewModel(router: router, storage: storage, notificationService: notificationService)
        return TaskListView(viewModel: viewModel)
    }
    
    func buildAddTaskView() -> some View {
        let viewModel = AddTaskViewModel(storage: storage, notificationService: notificationService)
        return AddTaskView(viewModel: viewModel)
    }
    
    func buildEditTaskView(index: Int) -> some View  {
        let viewModel = EditTaskViewModel(indexOftask: index, router: router, storage: storage, notificationService: notificationService)
        return EditTaskView(viewModel: viewModel)
    }
}
