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
    @Query var tasks: [Task]
    @State var user: User
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
