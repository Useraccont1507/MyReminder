//
//  ModelData.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import Foundation

class ModelData: ObservableObject {
  @Published var tasks: [Task] = [
    Task(title: "Clean car", priority: .important,  isCompleted: false, date: Date.now),
    Task(title: "Clean home", priority: .normal, isCompleted: false, date: Date.now)
  ]
}
