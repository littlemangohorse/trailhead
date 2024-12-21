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
                .font(.title)
                .fontWeight(.bold)
            
            // Top overview text
            HStack {
                let name = stableUser?.name ?? "User"
                let taskCount = stableUser?.tasks.count ?? 0 <= 0 ? "no" : stableUser?.tasks.count.description
                let taskIcon = Image(systemName: "checklist")
                let habitCount = stableUser?.habits.count ?? 0 <= 0 ? "no" : stableUser?.habits.count.description
                let habitIcon = Image(systemName: "point.forward.to.point.capsulepath.fill")
                
                Text("Hello, \(name)! \(Image(systemName: "heart.fill")), you have \(taskIcon) \(taskCount!) tasks and \(habitIcon) \(habitCount!) habits to complete today.")
                    .padding(.top, 3)
            }
            
            
            // Task List View
            
            Spacer()
            
            // Drawer
            
            
        }
        .padding(.horizontal)
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

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
