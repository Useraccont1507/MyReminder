//
//  TaskModel.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
  var id = UUID()
  var title: String
  var priority: TaskPriority
  var isCompleted: Bool
  var date: Date
  var dateTextView: Text {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.timeZone = .current
    dateFormatter.calendar = .current
    dateFormatter.dateFormat = "MMM d, HH:mm"
    
    var color: Color = .gray
    if date <= Date.now && !isCompleted {
      color = .red
    }
    
    return Text(dateFormatter.string(from: date)).foregroundStyle(color)
  }
}

enum TaskPriority: String, CaseIterable, Identifiable {
  case important = "important"
  case normal = "normal"
  
  var id: UUID {
    UUID()
  }
}
