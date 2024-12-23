//
//  TaskViews.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData

struct TaskCard: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Text(task.title)
                .font(.headline)
                .padding()
            
            Spacer()
            
            Button {
                task.completed.toggle()
                print(task.completed)
            } label: {
                if task.completed {
                    symbol("checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                } else {
                    symbol("checkmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                }
            }.buttonStyle(PlainButtonStyle())
                .padding()

        }
        .basicStyle()
    }
}
