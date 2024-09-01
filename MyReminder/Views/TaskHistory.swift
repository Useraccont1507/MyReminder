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
              HistoryTaskView(listTitle: "Today", tasks: todayTasks)
            } label: {
              ComponentView(
                labelText: "Today",
                labelCount: todayTasks.count,
                systemImageName: "calendar.circle.fill",
                imageForegroundColor: .yellow
              )
                .padding(.leading)
                .padding(.vertical)
            }
            NavigationLink {
              HistoryTaskView(listTitle: "All", tasks: modelData.taskHistory)
            } label: {
              ComponentView(
                labelText: "All",
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
              HistoryTaskView(listTitle: "Completed", tasks: completedTasks)
            } label: {
              ComponentView(
                labelText: "Completed",
                labelCount: completedTasks.count,
                systemImageName: "checkmark.circle.fill",
                imageForegroundColor: .green
              )
                .padding(.leading)
            }
            NavigationLink {
              HistoryTaskView(listTitle: "Incompleted", tasks: incompletedTasks)
            } label: {
              ComponentView(
                labelText: "Incompleted",
                labelCount: incompletedTasks.count,
                systemImageName: "xmark.circle.fill",
                imageForegroundColor: .red
              )
                .padding(.trailing)
            }
          }
        }
        .background(Color(UIColor.secondarySystemBackground))
      }
      .navigationTitle("History")
      .background(Color(UIColor.secondarySystemBackground))
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
