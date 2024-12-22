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
    @Query var users: [User]
    @State var user: User
    
    var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted).description)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Top overview text
                    let taskIcon = Image(systemName: "checklist")
                    let habitIcon = Image(systemName: "point.forward.to.point.capsulepath.fill")
//                        
                    Group {
                        Text("Hello, ").foregroundStyle(.secondary) + Text("\(user.name)\(symbol("heart.fill")) ") +
                        Text("You have ").foregroundStyle(.secondary) + Text("\(taskIcon) \(user.tasks.count) tasks ") +
                        Text("and ").foregroundStyle(.secondary) + Text("\(habitIcon) \(user.habits.count) habits today.")
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
                
            // Task List View
                
            Spacer()
        }
        .sheet(isPresented: .constant(true)) {
            FunctionDrawer(searchText: "", user: user, functions: [])
                .presentationDetents([.height(110), .large])
                .presentationCornerRadius(30)
                .interactiveDismissDisabled()
                .presentationBackground(.clear)
                .background(.ultraThinMaterial)
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
        }.onAppear {
            initUser()
        }
    }
    func initUser() {
        withAnimation {
            if users.isEmpty {
                print("Creating new Jane Doe...")
                let newUserPreferences = Preferences(isNotificationsEnabled: true)
                let newUser = User(joinDate: Date(), name: "Jane Doe", tasks: [], habits: [], prefs: newUserPreferences, classes: [])
                self.modelContext.insert(newUser)
                user = newUser
            }
        }
    }
}

func symbol(_ name: String) -> Image {
    return Image(systemName: name)
}

#Preview {
    ContentView(user: basicUser)
        .modelContainer(for: User.self, inMemory: true)
}
