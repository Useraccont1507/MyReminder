//
//  TabView.swift
//  MyReminder
//
//  Created by Illia Verezei on 08.03.2025.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var router: Router
    var builder: Builder
    
    var body: some View {
        TabView {
            builder.buildTaskListRouterFlow()
                .tabItem {
                    Label("tasks".localized.localizedCapitalized, systemImage: "list.bullet")
                }
            builder.buildAddTaskView()
                .tabItem {
                    Label("new_task".localized, systemImage: "plus")
                }
        }
    }
}
