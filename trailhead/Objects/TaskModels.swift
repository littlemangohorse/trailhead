//
//  DataModels.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

typealias Task = ModelSchemaV2.Task

enum ModelSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [
            Self.Task.self,
            Self.User.self,
            Self.Habit.self
        ]
    }
    
    @Model
    final class Task: Identifiable, Equatable {
        var id: UUID
        var title: String
        var details: String
        var dueDate: Date?
        var completed: Bool
        var recurring: Bool
        var frequency: Frequency?
        
        init(id: UUID, title: String, details: String, dueDate: Date?, completed: Bool, recurring: Bool, frequency: Frequency? = nil) {
            self.id = id
            self.title = title
            self.details = details
            self.dueDate = dueDate
            self.completed = completed
            self.recurring = recurring
            self.frequency = frequency
        }
    }

}

enum ModelSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [
            Self.Task.self,
            ModelSchemaV1.User.self,
            ModelSchemaV1.Habit.self
        ]
    }
    
    @Model
    final class Task: Identifiable, Equatable {
        var id: UUID = UUID()
        var title: String = ""
        var details: String = ""
        var date: Date = Date()
        var completed: Bool = false
        var recurring: Bool = false
        var frequency: Frequency?
        
        init(id: UUID, title: String, details: String, date: Date, completed: Bool, recurring: Bool, frequency: Frequency? = nil) {
            self.id = id
            self.title = title
            self.details = details
            self.date = date
            self.completed = completed
            self.recurring = recurring
            self.frequency = frequency
        }
    }

}


enum ModelSchemaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ModelSchemaV1.self, ModelSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [
            migrateV1toV2
            
        ]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: ModelSchemaV1.self,
        toVersion: ModelSchemaV2.self) { context in
            let oldTasks = try context.fetch(FetchDescriptor<ModelSchemaV1.Task>())
            
            for task in oldTasks {
                let newTask = ModelSchemaV2.Task(id: task.id, title: task.title, details: task.details, date: task.dueDate ?? Date(), completed: task.completed, recurring: task.recurring)
                
                context.insert(newTask)
                context.delete(task)
            }
            try? context.save()
            
        } didMigrate: { context in
            print("Migrated from ModelSchemaV1 to ModelSchemaV2")
        }
}
