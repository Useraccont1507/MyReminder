//
//  CoreDataService.swift
//  MyReminder
//
//  Created by Illia Verezei on 07.03.2025.
//

import CoreData

final class CoreDataService {
    private let context: NSManagedObjectContext
    
    init() {
        context = CoreDataManager.shared.context
    }
    
    func saveTask(_ task: Task) {
        let entity = TaskEntity(context: context)
        entity.id = task.id
        entity.title = task.title
        entity.body = task.body
        entity.date = task.date
        entity.isCompleted = task.isCompleted
        entity.priority = task.priority.rawValue
        saveContext()
    }
    
    func loadTasks() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        do {
            return try context.fetch(request).map { entity in
                Task(id: entity.id! ,title: entity.title!, body: entity.body, priority: TaskPriority(rawValue: entity.priority!)!, isCompleted: entity.isCompleted, date: entity.date!)
            }
        } catch {
            print("Failed to load tasks from storage:\n \(error)")
            return []
        }
    }
    
    func editTask(_ task: Task) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let taskEntity = try context.fetch(request).first
            taskEntity?.id = task.id
            taskEntity?.title = task.title
            taskEntity?.body = task.body
            taskEntity?.date = task.date
            taskEntity?.isCompleted = task.isCompleted
            taskEntity?.priority = task.priority.rawValue
            saveContext()
        } catch {
            print("cannot find user in storage: \(error)")
        }
    }
    
    func deleteTask(_ task: Task) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            guard let taskEntity = try context.fetch(request).first else { return }
            context.delete(taskEntity)
            saveContext()
        } catch {
            print("Delete error: \n \(error.localizedDescription)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("context save error: \n \(error.localizedDescription)")
        }
    }
}
