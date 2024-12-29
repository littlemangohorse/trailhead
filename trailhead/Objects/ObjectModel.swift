//
//  ObjectModel.swift
//  trailhead
//
//  Created by Matthew Smith on 12/29/24.
//

import SwiftUI
import SwiftData
import EventKit

typealias Object = ModelSchemaV3.ObjectModel

extension ModelSchemaV1 {
    @Model
    class ObjectModel: Identifiable, Equatable {
        var id: UUID = UUID()
        var type: ObjectType = ObjectType.unknown
        var name: String = ""
        var completed: Bool = false
        var details: String = ""
        var date: Date = Date()
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        init(id: UUID, type: ObjectType, name: String, completed: Bool, details: String, date: Date, startDate: Date? = nil, endDate: Date? = nil) {
            self.id = id
            self.type = type
            self.name = name
            self.completed = completed
            self.details = details
            self.date = date
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}

extension ModelSchemaV2 {
    @Model
    class ObjectModel: Identifiable, Equatable {
        var id: UUID = UUID()
        var idString: String = ""
        var type: ObjectType = ObjectType.unknown
        var name: String = ""
        var completed: Bool = false
        var details: String = ""
        var date: Date = Date()
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        init(id: UUID, type: ObjectType, name: String, completed: Bool, details: String, date: Date, startDate: Date? = nil, endDate: Date? = nil) {
            self.id = id
            self.idString = id.uuidString
            self.type = type
            self.name = name
            self.completed = completed
            self.details = details
            self.date = date
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}

extension ModelSchemaV3 {
    @Model
    class ObjectModel: Identifiable, Equatable {
        var id: UUID = UUID()
        var eventIdString: String = ""
        var type: ObjectType = ObjectType.unknown
        var name: String = ""
        var completed: Bool = false
        var details: String = ""
        var date: Date = Date()
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        init(id: UUID, eventIdString: String?, type: ObjectType, name: String, completed: Bool, details: String, date: Date, startDate: Date? = nil, endDate: Date? = nil) {
            self.id = id
            self.eventIdString = eventIdString ?? ""
            self.type = type
            self.name = name
            self.completed = completed
            self.details = details
            self.date = date
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}

enum ObjectType: String, CaseIterable, Codable {
    case event = "Event"
    case task = "Task"
    case habit = "Habit"
    case unknown = "Unidentified"
}
