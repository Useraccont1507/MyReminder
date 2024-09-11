//
//  Storage.swift
//  MyReminder
//
//  Created by User on 04.09.2024.
//

import Foundation

class Storage {
  static let shared = Storage()
  private var storage = UserDefaults.standard
  private var storageKey = "storage_key_1234567890987654321"
  
  private init() {}
  
  func load() -> [Task] {
    var arrayToReturn: [Task] = []
    if let arrayOfDict = storage.array(forKey: storageKey) as? [[String: Any]] {
      print(arrayOfDict)
      for dict in arrayOfDict {
        let notificationIdentifier = dict["notificationIdentifier"] as! String
        let title = dict["title"] as! String
        let body = dict["body"] as! String?
        let priority = TaskPriority(rawValue: dict["priority"] as! String)!
        let isCompleted = dict["isCompleted"] as! Bool
        let date = dict["date"] as! Date
        
        arrayToReturn.append(
          Task(
            notificationIdentifier: notificationIdentifier,
            title: title,
            body: body,
            priority: priority,
            isCompleted: isCompleted,
            date: date
          )
        )
      }
    }
    print(arrayToReturn)
    return arrayToReturn
  }
  
  func save(tasks: [Task]) {
    var arrayOfDict: [[String:Any]] = []
    for task in tasks {
      var dict: [String: Any] = [:]
      dict["notificationIdentifier"] = task.notificationIdentifier
      dict["title"] = task.title
      dict["body"] = task.body
      dict["priority"] = task.priority.rawValue
      
      if task.isCompleted {
        dict["isCompleted"] = true
      } else {
        dict["isCompleted"] = false
      }
      
      dict["date"] = task.date
      arrayOfDict.append(dict)
    }
    print(arrayOfDict)
    storage.setValue(arrayOfDict, forKey: storageKey)
  }
}


