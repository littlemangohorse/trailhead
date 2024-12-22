//
//  trailheadApp.swift
//  trailhead
//
//  Created by Matthew Smith on 12/19/24.
//

import SwiftUI
import SwiftData

let basicPreference = Preferences(isNotificationsEnabled: false)
let basicUser = User(joinDate: Date(), name: "Nonpersistent User", tasks: [], habits: [], prefs: basicPreference, classes: [])

@main
struct trailheadApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var user: User?
    
    init() {
        let modelContext = sharedModelContainer.mainContext
        let fetchDescriptor = FetchDescriptor<User>()
        
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            
            for user in users {
                print("User: \(user.name)")
                self.user = user
                print(self.user?.name ?? "NO USER ASSIGNED")
            }
        } catch {
            print("None found")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(user: user ?? basicUser)
        }
        .modelContainer(sharedModelContainer)
    }
}
