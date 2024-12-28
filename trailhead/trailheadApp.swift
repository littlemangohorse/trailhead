//
//  trailheadApp.swift
//  trailhead
//
//  Created by Matthew Smith on 12/19/24.
//

import SwiftUI
import SwiftData

let basicPreference = Preferences(isNotificationsEnabled: false)
let basicUser = User(joinDate: Date(), name: "Nonpersistent User", prefs: basicPreference, classes: [])

@main
struct trailheadApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            User.self,
//            Task.self,
//            Habit.self
//        ])
//        
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
////            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
//    var user: User?
//    
//    init() {
//        let modelContext = sharedModelContainer.mainContext
//        let fetchDescriptor = FetchDescriptor<User>()
//        
//        do {
//            let users = try modelContext.fetch(fetchDescriptor)
//            
//            for user in users {
//                print("User: \(user.name)")
//                self.user = user
//                print(self.user?.name ?? "NO USER ASSIGNED")
//            }
//            
//            if users.isEmpty {
//                print("Creating new Jane Doe...")
//                let newUserPreferences = Preferences(isNotificationsEnabled: true)
//                let newUser = User(joinDate: Date(), name: "Jane Doe", prefs: newUserPreferences, classes: [])
//                modelContext.insert(newUser)
//                self.user = newUser
//            }
//        } catch {
//            print("None found")
//        }
//    }
    
    let sharedContainer: ModelContainer
    var user: User?
    
    init() {
        // Task Management
        do {
            sharedContainer = try ModelContainer(
                for: Task.self, User.self, Habit.self,
                migrationPlan: ModelSchemaMigrationPlan.self
            )
            
            let modelContext = sharedContainer.mainContext
            let fetchDescriptor = FetchDescriptor<User>()
            
            let users = try modelContext.fetch(fetchDescriptor)
            
            for user in users {
                print("User: \(user.name)")
                self.user = user
                print(self.user?.name ?? "NO USER ASSIGNED")
            }
            
            if users.isEmpty {
                print("Creating new Jane Doe...")
                let newUserPreferences = Preferences(isNotificationsEnabled: true)
                let newUser = User(joinDate: Date(), name: "Jane Doe", prefs: newUserPreferences, classes: [])
                modelContext.insert(newUser)
                self.user = newUser
            }
        } catch {
            fatalError("Failed to initialize model container.")
        }
        
        // User Management
    }

    var body: some Scene {
        WindowGroup {
            ContentView(user: user ?? basicUser)
        }
        .modelContainer(sharedContainer)
    }
}
