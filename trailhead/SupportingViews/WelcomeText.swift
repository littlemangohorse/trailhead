//
//  WelcomeText.swift
//  trailhead
//
//  Created by Matthew Smith on 12/23/24.
//

import SwiftUI
import SwiftData

struct WelcomeText: View {
    @Binding var user: User
    @Query var tasks: [Task]
    @Query var habits: [Habit]
    var body: some View {
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
                Text("You have ").foregroundStyle(.secondary) + Text("\(taskIcon) \(tasks.count) tasks ") +
                Text("and ").foregroundStyle(.secondary) + Text("\(habitIcon) \(habits.count) habits today.")
            }
            .font(.title3)
            .fontWeight(.semibold)
        }.padding(.horizontal)
    }
}
