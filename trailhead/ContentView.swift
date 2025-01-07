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
    @Query var tasks: [Object]
    @State var user: User
    @State var selectedDetent: PresentationDetent = .height(100)
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText(user: $user)
                
                let calendar = Calendar.current
                let today = Date()

                let filteredTasks = tasks.filter {
                    calendar.isDate($0.date, inSameDayAs: today)
                }.sorted(by: { $0.date < $1.date })
                
                ForEach(filteredTasks) { task in
                    ObjectCard(object: task, user: user) // Replace with your content for the task
                        .padding(.horizontal)
                }
                
                Spacer()
                
            }
            .sheet(isPresented: .constant(true)) {
                sheetContent
                    .ignoresSafeArea()
                    .presentationDetents([.height(100), .large], selection: $selectedDetent.animation(.snappy.speed(2.9)))
            }
            
        }.frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var sheetContent: some View {
        FunctionDrawer(selectedDetent: self.$selectedDetent, user: user, functions: [])
            .presentationCornerRadius(30)
            .interactiveDismissDisabled()
            .background(.ultraThinMaterial)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    
}

func symbol(_ name: String) -> Image {
    return Image(systemName: name)
}

#Preview {
    ContentView(user: basicUser)
        .modelContainer(for: User.self, inMemory: true)
}
