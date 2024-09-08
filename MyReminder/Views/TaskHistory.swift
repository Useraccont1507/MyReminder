//
//  TaskHistory.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct TaskHistory: View {
  @EnvironmentObject var modelData: ModelData
  
  @State var todayTasks: [Task] = []
  @State var completedTasks: [Task] = []
  @State var incompletedTasks: [Task] = []

  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          HStack {
            NavigationLink {
              HistoryTaskView(listTitle: "today".localized.localizedCapitalized, tasks: todayTasks)
            } label: {
              ComponentView(
                labelText: "today".localized.localizedCapitalized,
                labelCount: todayTasks.count,
                systemImageName: "calendar.circle.fill",
                imageForegroundColor: .yellow
              )
                .padding(.leading)
                .padding(.vertical)
            }
            NavigationLink {
              HistoryTaskView(listTitle: "all".localized.localizedCapitalized, tasks: modelData.taskHistory)
            } label: {
              ComponentView(
                labelText: "all".localized.localizedCapitalized,
                labelCount: modelData.taskHistory.count,
                systemImageName: "folder.circle.fill",
                imageForegroundColor: .blue
              )
                .padding(.trailing)
                .padding(.vertical)
            }
          }
          HStack {
            NavigationLink {
              HistoryTaskView(listTitle: "completed".localized.localizedCapitalized, tasks: completedTasks)
            } label: {
              ComponentView(
                labelText: "completed".localized.localizedCapitalized,
                labelCount: completedTasks.count,
                systemImageName: "checkmark.circle.fill",
                imageForegroundColor: .green
              )
                .padding(.leading)
            }
            NavigationLink {
              HistoryTaskView(listTitle: "incompleted".localized.localizedCapitalized, tasks: incompletedTasks)
            } label: {
              ComponentView(
                labelText: "incompleted".localized.localizedCapitalized,
                labelCount: incompletedTasks.count,
                systemImageName: "xmark.circle.fill",
                imageForegroundColor: .red
              )
                .padding(.trailing)
            }
          }
        }
        .background(Color(UIColor.historyBackground))
      }
      .navigationTitle("history".localized.localizedCapitalized)
      .background(Color(UIColor.historyBackground))
      .toolbar(content: {
        Button("delete_all_history".localized) {
          modelData.deleteAllHistory()
          todayTasks = modelData.taskHistory.filter { Calendar.current.isDateInToday($0.date) }
          completedTasks = modelData.taskHistory.filter { $0.isCompleted == true }
          incompletedTasks = modelData.taskHistory.filter { $0.isCompleted == false }
        }
      })
    }
    .onAppear {
      todayTasks = modelData.taskHistory.filter { Calendar.current.isDateInToday($0.date) }
      completedTasks = modelData.taskHistory.filter { $0.isCompleted == true }
      incompletedTasks = modelData.taskHistory.filter { $0.isCompleted == false }
    }
  }
}

#Preview {
  TaskHistory()
    .environmentObject(ModelData())
}
