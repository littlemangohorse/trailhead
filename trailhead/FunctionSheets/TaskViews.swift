//
//  TaskViews.swift
//  trailhead
//
//  Created by Matthew Smith on 12/22/24.
//

import SwiftUI
import SwiftData

struct ObjectCard: View {
    @Bindable var task: Task
    @State var user: User
    @Query var tasks: [Task]
    @State var displayEditSheet: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack {
            Text(task.title)
                .font(.headline)
                .padding()
                .onTapGesture {
                    self.displayEditSheet.toggle()
                }
            
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
            .padding(3.5)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1.8)
                    .fill(Color.secondary.opacity(0.2))
            )
        .id(task.id)
        .contextMenu {
            Text(task.details)
            
            Button {
                print("Remove")
                modelContext.delete(task)
            } label: {
                Label("Delete", systemImage: "minus.circle")
            }
            
            Button {
                print("Edit")
                self.displayEditSheet.toggle()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
        .sheet(isPresented: $displayEditSheet) {
            EditTaskSheet(task: self.task)
        }
    }
}
