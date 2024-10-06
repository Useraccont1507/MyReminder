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
  private var storageKeyForNormalList = "storage_key_1234567890987654321"
  private var storageKeyForHistoryList = "storage_key_1234567890987655555"
  
  private init() {}
  
  func load(forWhich: ArrayType) -> [Task] {
    let storageKey: String
    switch forWhich {
    case .normalList:
      storageKey = storageKeyForNormalList
    case .historyList:
      storageKey = storageKeyForHistoryList
    }
    
    var arrayToReturn: [Task] = []
    if let arrayOfDict = storage.array(forKey: storageKey) as? [[String: Any]] {
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
    return arrayToReturn
  }
  
  func save(tasks: [Task], forWhich: ArrayType) {
    let storageKey: String
    switch forWhich {
    case .normalList:
      storageKey = storageKeyForNormalList
    case .historyList:
      storageKey = storageKeyForHistoryList
    }
    
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
    storage.setValue(arrayOfDict, forKey: storageKey)
  }
  
  enum ArrayType {
    case normalList
    case historyList
  }
}

