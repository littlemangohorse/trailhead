//
//  WelcomeText.swift
//  trailhead
//
//  Created by Matthew Smith on 12/23/24.
//

import SwiftUI
import SwiftData
import EventKit

struct WelcomeText: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var user: User
    @Query var objects: [Object]
//    @State var events: [EKEvent] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            HStack(alignment: .top) {
                
                HStack {
                    Text(Date().formatted(.dateTime.weekday(.abbreviated)))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Circle()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.accent)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(Date().formatted(.dateTime.month(.wide).day()))
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(Date().formatted(.dateTime.year()))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                }
            }
            
            // Top overview text
            let taskIcon = Image(systemName: "checkmark.square")
            let habitIcon = Image(systemName: "point.forward.to.point.capsulepath.fill")
            let calIcon = Image(systemName: "calendar")
            
            let tasks = objects.filter( { $0.type == .task })
            let events = objects.filter( { $0.type == .event })
            let habits = objects.filter( { $0.type == .habit })
//
            Group {
                Text("Hello, ").foregroundStyle(.secondary) +
                Text("\(user.name). ") +
                Text("You have ").foregroundStyle(.secondary) +
                Text("\(taskIcon) \(tasks.count) \(tasks.count == 1 ? "task" : "tasks"), ") +
                Text("\(calIcon) \(events.count) \(events.count == 1 ? "event" : "events"), ") +
                Text("and ").foregroundStyle(.secondary) +
                Text("\(habitIcon) \(habits.count) habits today. ")
            }
            .font(.largeTitle)
            .fontWeight(.semibold)
        }.padding(.horizontal)
            .onAppear {
                Task {
                    await todaysEvents()
                }
            }
    }
    
    func todaysEvents() async {
        // Create an event store
        let store = EKEventStore()

        // Request full access
        store.requestFullAccessToEvents { granted, fail in
            print(granted)
        }

        // Create a predicate
        guard let interval = Calendar.current.dateInterval(of: .day, for: Date.now) else { return }
        let predicate = store.predicateForEvents(withStart: interval.start, end: interval.end, calendars: nil)

        // Fetch the events
        
        for event in store.events(matching: predicate) {
            print("EKEVENTS TODAY: \(String(describing: event.title))")
            
            let newEvent = Object(id: UUID(), eventIdString: event.eventIdentifier, type: .event, name: event.title, completed: false, details: event.notes ?? "", date: event.startDate, startDate: event.startDate, endDate: event.endDate)
            
            for storedEvent in objects.filter( { $0.type == .event } ) {
                if storedEvent.eventIdString == event.eventIdentifier {
                    modelContext.delete(storedEvent)
                } else if storedEvent.date < Date.now {
                    modelContext.delete(storedEvent)
                }
            }
            
            modelContext.insert(newEvent)
        }
        
//        for storedEvents in objects.filter( { $0.type == .event } ) {
//            modelContext.delete(storedEvents)
//        }
    }
}
