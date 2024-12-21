//
//  ContentView.swift
//  trailhead
//
//  Created by Matthew Smith on 12/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State var stableUser: User?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Date().formatted(date: .abbreviated, time: .omitted).description)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Top overview text
            Group {
                let name = stableUser?.name ?? "User"
                let taskCount = stableUser?.tasks.count ?? 0 <= 0 ? "no" : stableUser?.tasks.count.description
                let taskIcon = Image(systemName: "checklist")
                let habitCount = stableUser?.habits.count ?? 0 <= 0 ? "no" : stableUser?.habits.count.description
                let habitIcon = Image(systemName: "point.forward.to.point.capsulepath.fill")
                
                Group {
                    Text("Hello, ").foregroundStyle(.secondary) + Text("\(name)\(symbol("heart.fill")) ") +
                    Text("You have ").foregroundStyle(.secondary) + Text("\(taskIcon) \(taskCount!) tasks ") +
                    Text("and ").foregroundStyle(.secondary) + Text("\(habitIcon) \(habitCount!) habits.")
                }
                .font(.title3)
                .fontWeight(.semibold)
            }
            
            // Task List View
            
            Spacer()
            
            // Drawer
            
            
        }
        .onAppear {
            initializeUser()
        }
    }
    
    private func initializeUser() {
        withAnimation {
            if user.isEmpty {
                print("Creating new Jane Doe...")
                let newUserPreferences = Preference(isNotificationsEnabled: true)
                let newUser = User(joinDate: Date(), name: "Jane Doe", tasks: [], habits: [], prefs: newUserPreferences, classes: [])
                modelContext.insert(newUser)
                self.stableUser = newUser
            } else {
                print("Pulling stored user...")
                self.stableUser = user.first
                
            }
        }
    }
}

func symbol(_ name: String) -> Image {
    return Image(systemName: name)
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
