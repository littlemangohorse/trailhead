//
//  Item.swift
//  trailhead
//
//  Created by Matthew Smith on 12/19/24.
//

import Foundation
import SwiftData
import SwiftUI

// MARK: User model
// 2 Main static reservoirs of information: Tasks, added on one-time bases, and Habits, daily recurring tasks.
// Tasks can be recurring or singular.
// The user model also stores Classes. Classes can be set on a daily, weekly, or in-the-middle recurrance.
// The user model includes a Preference model to store basic information such as customization options: TBD.

@Model
final class User: Identifiable {
    var joinDate: Date
    var name: String
    var tasks: [Task]
    var habits: [Habit]
    var prefs: Preferences
    var classes: [Class]
    
    init(joinDate: Date, name: String, tasks: [Task], habits: [Habit], prefs: Preferences, classes: [Class]) {
        self.joinDate = joinDate
        self.name = name
        self.tasks = tasks
        self.habits = habits
        self.prefs = prefs
        self.classes = classes
    }
}

// MARK: Task Model
// Includes ID for pulling, Title and Details, relevant date (if applicable,) due date, completion and recurrance (frequency as well,) and the associated class.

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
    
    init(id: UUID, title: String, details: String, dueDate: Date? = nil, completed: Bool, recurring: Bool, frequency: Frequency? = nil, classes: [Class]? = nil) {
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

@Model
final class Frequency: Identifiable {
    var id: Int
    var name: String
    var days: [Day]
    
    init(id: Int, name: String, days: [Day]) {
        self.id = id
        self.name = name
        self.days = days
    }
}

@Model
final class Day: Identifiable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
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

// MARK: Preference Model

@Model
final class Preferences {
    var isNotificationsEnabled: Bool
    
    init(isNotificationsEnabled: Bool) {
        self.isNotificationsEnabled = isNotificationsEnabled
    }
}


// MARK: Class and Teacher Models

@Model
final class Class: Identifiable {
    var id: Int
    var name: String
    var instructors: [Instructor]
    var icon: String
    var color: String
    
    init(id: Int, name: String, instructors: [Instructor], icon: String, color: String) {
        self.id = id
        self.name = name
        self.instructors = instructors
        self.icon = icon
        self.color = color
    }
}

@Model
final class Instructor: Identifiable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    
    init(id: Int, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}
