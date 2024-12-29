//
//  DataModels.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

enum ModelSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [
            Self.User.self,
            Self.ObjectModel.self
        ]
    }

}

enum ModelSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [
            ModelSchemaV1.User.self,
            Self.ObjectModel.self
            
        ]
    }

}

enum ModelSchemaV3: VersionedSchema {
    static var versionIdentifier = Schema.Version(3, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [
            ModelSchemaV1.User.self,
            Self.ObjectModel.self
            
        ]
    }

}


enum ModelSchemaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ModelSchemaV1.self, ModelSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [
            migrateV1toV2, migrateV2toV3
        ]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: ModelSchemaV1.self,
        toVersion: ModelSchemaV2.self) { context in
            let oldObjects = try context.fetch(FetchDescriptor<ModelSchemaV1.ObjectModel>())
            
            for oldObject in oldObjects {
                
                let newObject = ModelSchemaV2.ObjectModel(
                    id: oldObject.id,
                    type: oldObject.type,
                    name: oldObject.name,
                    completed: oldObject.completed,
                    details: oldObject.details,
                    date: oldObject.date,
                    startDate: oldObject.startDate)
                
                context.insert(newObject)
                context.delete(oldObject)
            }
            
            try? context.save()
            
        } didMigrate: { context in
            print("Migrated from ModelSchemaV1 to ModelSchemaV2")
        }
    
    static let migrateV2toV3 = MigrationStage.custom(
        fromVersion: ModelSchemaV2.self,
        toVersion: ModelSchemaV3.self) { context in
            let oldObjects = try context.fetch(FetchDescriptor<ModelSchemaV2.ObjectModel>())
            
            for oldObject in oldObjects {
                
                let newObject = ModelSchemaV3.ObjectModel(
                    id: oldObject.id,
                    eventIdString: "",
                    type: oldObject.type,
                    name: oldObject.name,
                    completed: oldObject.completed,
                    details: oldObject.details,
                    date: oldObject.date,
                    startDate: oldObject.startDate)
                
                context.insert(newObject)
                context.delete(oldObject)
            }
            
            try? context.save()
            
        } didMigrate: { context in
            print("Migrated from ModelSchemaV2 to ModelSchemaV3")
        }
}
