//
//  ContentView.swift
//  trailhead
//
//  Created by Matthew Smith on 12/19/24.
//

import SwiftUI
import SwiftData
import Glossy

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]
    @State var user: User
    @State private var selectedDetent: PresentationDetent = .height(100)
    
    var body: some View {
        ZStack {
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
                
                ForEach($user.tasks) { task in
                    TaskCard(task: task)
                        .id(task.id)
                        .onAppear {
                            print("\(task.title), \(task.completed)")
                        }
                }
                
            Spacer()
                
            }
            .sheet(isPresented: .constant(true)) {
                sheetContent
                    .presentationDetents([.height(100), .large], selection: $selectedDetent.animation(.snappy.speed(2.9)))
            }.onAppear {
                initUser()
            }
            
        }.frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
        private var sheetContent: some View {
            switch selectedDetent {
            case .large:
                FunctionDrawer(searchText: "", user: user, functions: [], isFullScreen: true)
                    .presentationCornerRadius(30)
                    .interactiveDismissDisabled()
                    .presentationBackground(.clear)
                    .background(.ultraThinMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
            case .height(100):
                FunctionDrawer(searchText: "", user: user, functions: [], isFullScreen: false)
                    .presentationCornerRadius(30)
                    .interactiveDismissDisabled()
                    .presentationBackground(.clear)
                    .background(.ultraThinMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
            default:
                FunctionDrawer(searchText: "", user: user, functions: [], isFullScreen: true)
                    .presentationCornerRadius(30)
                    .interactiveDismissDisabled()
                    .presentationBackground(.clear)
                    .background(.ultraThinMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
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
