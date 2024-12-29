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
    @Binding var user: User
    @Query var tasks: [Task]
    @Query var habits: [Habit]
    
    var store = EKEventStore()
    @State var events: [EKEvent] = []
    
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
            
            let busyness = if tasks.count + habits.count > 0 {
                Text("not too busy")
            } else if tasks.count + habits.count > 5 {
                Text("busy")
            } else if tasks.count + habits.count > 10 {
                Text("really busy")
            } else {
                Text("free")
            }
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
                requestAccessToCalendar()
                todaysEvents()
            }
    }
    
    func requestAccessToCalendar() {
        store.requestFullAccessToEvents { granted, fail in
            print(granted)
        }
    }
    
    func todaysEvents() {
            let calendar = Calendar.autoupdatingCurrent
            let startDate = Date.now
            var onDayComponents = DateComponents()
            onDayComponents.day = 1
            let endDate = calendar.date(byAdding: onDayComponents, to: .now)!
            let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
            events = store.events(matching: predicate)
            
        }
}
