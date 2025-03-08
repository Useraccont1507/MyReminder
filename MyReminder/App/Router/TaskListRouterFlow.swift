//
//  TaskListRouterFlow.swift
//  MyReminder
//
//  Created by Illia Verezei on 08.03.2025.
//

import SwiftUI

struct TaskListRouterFlow: View {
    @ObservedObject var router: Router
    var builder: Builder
    
    var body: some View {
        NavigationStack(path: $router.path) {
            builder.buildTaskListView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .edit(let i): builder.buildEditTaskView(index: i)
                    }
                }
        }

    }
}

