//
//  DataAttributes.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftData
import SwiftUI

// MARK: Preference Model
@Model
class Preferences {
    var isNotificationsEnabled: Bool
    
    init(isNotificationsEnabled: Bool) {
        self.isNotificationsEnabled = isNotificationsEnabled
    }
}


// MARK: Class and Teacher Models
@Model
class Class: Identifiable {
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
class Instructor: Identifiable {
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


