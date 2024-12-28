//
//  UserModels.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

typealias User = ModelSchemaV1.User

extension ModelSchemaV1 {
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
}
