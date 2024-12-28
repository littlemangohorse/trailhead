//
//  DataModels.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

@Model
final class Task: Identifiable, Equatable {
    var id: UUID
    var title: String
    var details: String
    var dueDate: Date?
    var completed: Bool
    var recurring: Bool
    var frequency: Frequency?
    var classes: [Class]?
    
    init(id: UUID, title: String, details: String, dueDate: Date?, completed: Bool, recurring: Bool, frequency: Frequency? = nil, classes: [Class]? = nil) {
        self.id = id
        self.title = title
        self.details = details
        self.dueDate = dueDate
        self.completed = completed
        self.recurring = recurring
        self.frequency = frequency
        self.classes = classes
    }
}

// MARK: Habit Model
@Model
final class Habit: Identifiable {
    var id: Int
    var name: String
    var frequency: Frequency
    var days: [Day]
    var completed: Bool
    
    init(id: Int, name: String, frequency: Frequency, days: [Day], completed: Bool) {
        self.id = id
        self.name = name
        self.frequency = frequency
        self.days = days
        self.completed = completed
    }
}

@Model
final class User: Identifiable {
    var joinDate: Date
    var name: String
    var prefs: Preferences
    var classes: [Class]
    
    init(joinDate: Date, name: String, prefs: Preferences, classes: [Class]) {
        self.joinDate = joinDate
        self.name = name
        self.prefs = prefs
        self.classes = classes
    }
}
