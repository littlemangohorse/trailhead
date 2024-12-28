//
//  HabitModels.swift
//  trailhead
//
//  Created by Matthew Smith on 12/27/24.
//

import SwiftUI
import SwiftData

typealias Habit = ModelSchemaV1.Habit

extension ModelSchemaV1 {
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
}
