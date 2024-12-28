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
    @State var tasks: [Task]
    @State var selectedDetent: PresentationDetent = .height(100)
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText(user: $user)
                
                // Task List View
                
                ScrollView {
                    ForEach(tasks) { task in
                        TaskCard(task: task, user: user)
                    }
                }.padding(.horizontal)
                
                Spacer()
                
            }
            .sheet(isPresented: .constant(true)) {
                sheetContent
                    .ignoresSafeArea()
                    .presentationDetents([.height(100), .large], selection: $selectedDetent.animation(.snappy.speed(2.9)))
            }.onAppear {
                initUser()
            }
            .onChange(of: user.tasks) { oldValue, newValue in
                tasks = user.tasks
            }
            
        }.frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var sheetContent: some View {
        FunctionDrawer(selectedDetent: self.$selectedDetent, user: user, functions: [])
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
    ContentView(user: basicUser, tasks: [])
        .modelContainer(for: User.self, inMemory: true)
}
