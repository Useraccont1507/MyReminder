//
//  HistoryTaskListRow.swift
//  MyReminder
//
//  Created by User on 04.09.2024.
//

import SwiftUI

struct HistoryTaskListRow: View {
  var task: Task
    var body: some View {
      HStack {
        Text(task.title)
          .font(.body)
        
        Spacer()
        
        task.dateTextView
      }
    }
}

//#Preview {
//  HistoryTaskListRow(task: <#Task#>)
//}
